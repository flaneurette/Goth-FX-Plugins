-- Chord Progression Generator for Reaper
-- Circle of Fifths chord picker

local WINDOW_W, WINDOW_H = 500, 550
local CENTER_X, CENTER_Y = 250, 260
local RADIUS = 170
local NODE_RADIUS = 28

local mediaItem = nil
local midiTake = nil
local currentPositionPPQ = 0
local isMinorMode = false
local use7th = false
local lastClickedIndex = nil
local progressionList = {}
local statusMessage = "Click a chord to start your progression"
local lastMouseState = 0

local CHORD_LENGTH_BEATS = 4

-- Circle of fifths order (major keys), with MIDI root note (octave 4 = 60)
local circleOfFifths = {
  { name = "C",  root = 60 },
  { name = "G",  root = 67 },
  { name = "D",  root = 62 },
  { name = "A",  root = 69 },
  { name = "E",  root = 64 },
  { name = "B",  root = 71 },
  { name = "F#", root = 66 },
  { name = "Db", root = 61 },
  { name = "Ab", root = 68 },
  { name = "Eb", root = 63 },
  { name = "Bb", root = 70 },
  { name = "F",  root = 65 },
}

-- Triads and 7th chord intervals
local MAJOR_TRIAD = {0, 4, 7}
local MINOR_TRIAD = {0, 3, 7}
local MAJOR_7TH   = {0, 4, 7, 11}
local MINOR_7TH   = {0, 3, 7, 10}

-- Button positions
local clearBtnX, clearBtnY, clearBtnW, clearBtnH = 20, 20, 80, 30
local modeBtnX, modeBtnY, modeBtnW, modeBtnH = 120, 20, 120, 30
local seventhBtnX, seventhBtnY, seventhBtnW, seventhBtnH = 260, 20, 100, 30

--------------------------------------------------------------------------
-- Create or get MIDI item/track
--------------------------------------------------------------------------
local function getOrCreateMidiItem()
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.InsertTrackAtIndex(0, true)
    track = reaper.GetTrack(0, 0)
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "Chord Progression", true)
  end

  local editCursorPos = reaper.GetCursorPosition()
  local bpm = reaper.Master_GetTempo()
  local secPerBeat = 60 / bpm
  local itemLengthBeats = 32 * 4 -- room for 32 chords
  local itemLengthSec = itemLengthBeats * secPerBeat

  mediaItem = reaper.CreateNewMIDIItemInProj(track, editCursorPos, editCursorPos + itemLengthSec, false)
  midiTake = reaper.GetActiveTake(mediaItem)

  return mediaItem, midiTake
end

--------------------------------------------------------------------------
-- Add a chord into the MIDI take at the current position
--------------------------------------------------------------------------
local function addChordToMidi(rootNote, intervals, chordName)
  if not midiTake then return end

  local startTime = reaper.MIDI_GetProjTimeFromPPQPos(midiTake, currentPositionPPQ)
  local endTime = startTime + (CHORD_LENGTH_BEATS * (60 / reaper.Master_GetTempo()))

  local startPPQ = reaper.MIDI_GetPPQPosFromProjTime(midiTake, startTime)
  local endPPQ = reaper.MIDI_GetPPQPosFromProjTime(midiTake, endTime)

  for _, interval in ipairs(intervals) do
    local pitch = rootNote + interval
    reaper.MIDI_InsertNote(midiTake, false, false, startPPQ, endPPQ, 0, pitch, 100, false)
  end

  reaper.MIDI_Sort(midiTake)

  currentPositionPPQ = endPPQ
  table.insert(progressionList, chordName)
  statusMessage = "Progression: " .. table.concat(progressionList, " - ")

  reaper.UpdateArrange()
end

--------------------------------------------------------------------------
-- Clear all chords: fully deletes and recreates the MIDI item
--------------------------------------------------------------------------
local function clearAllChords()
  if mediaItem then
    local track = reaper.GetMediaItem_Track(mediaItem)
    reaper.DeleteTrackMediaItem(track, mediaItem)
  end

  mediaItem = nil
  midiTake = nil
  currentPositionPPQ = 0
  progressionList = {}
  lastClickedIndex = nil

  getOrCreateMidiItem()

  if mediaItem then
    reaper.SelectAllMediaItems(0, false)
    reaper.SetMediaItemSelected(mediaItem, true)
    reaper.Main_OnCommand(40153, 0) -- Open in built-in MIDI editor
  end

  reaper.TrackList_AdjustWindows(false)
  reaper.UpdateArrange()
  statusMessage = "Cleared! Click a chord to start your progression"
end

--------------------------------------------------------------------------
-- Helper: get correct interval set based on mode toggles
--------------------------------------------------------------------------
local function getIntervals()
  if isMinorMode and use7th then
    return MINOR_7TH
  elseif isMinorMode and not use7th then
    return MINOR_TRIAD
  elseif not isMinorMode and use7th then
    return MAJOR_7TH
  else
    return MAJOR_TRIAD
  end
end

local function getChordSuffix()
  if isMinorMode and use7th then
    return "m7"
  elseif isMinorMode and not use7th then
    return "m"
  elseif not isMinorMode and use7th then
    return "maj7"
  else
    return ""
  end
end

--------------------------------------------------------------------------
-- Drawing
--------------------------------------------------------------------------
local function drawButton(x, y, w, h, label, active)
  if active then
    gfx.set(0.3, 0.7, 0.3, 1)
  else
    gfx.set(0.3, 0.3, 0.3, 1)
  end
  gfx.rect(x, y, w, h, true)
  gfx.set(1, 1, 1, 1)
  gfx.rect(x, y, w, h, false)

  gfx.set(1, 1, 1, 1)
  gfx.setfont(1, "Arial", 14)
  local strW, strH = gfx.measurestr(label)
  gfx.x = x + (w - strW) / 2
  gfx.y = y + (h - strH) / 2
  gfx.drawstr(label)
end

local function draw()
  gfx.set(0.15, 0.15, 0.15, 1)
  gfx.rect(0, 0, WINDOW_W, WINDOW_H, true)

  -- Buttons
  drawButton(clearBtnX, clearBtnY, clearBtnW, clearBtnH, "Clear", false)
  drawButton(modeBtnX, modeBtnY, modeBtnW, modeBtnH, isMinorMode and "Mode: Minor" or "Mode: Major", isMinorMode)
  drawButton(seventhBtnX, seventhBtnY, seventhBtnW, seventhBtnH, use7th and "7th: On" or "7th: Off", use7th)

  -- Circle of fifths nodes
  for i, chord in ipairs(circleOfFifths) do
    local angle = (i - 1) * (2 * math.pi / 12) - math.pi / 2
    local nodeX = CENTER_X + RADIUS * math.cos(angle)
    local nodeY = CENTER_Y + RADIUS * math.sin(angle)

    -- Highlight last clicked chord
    if lastClickedIndex == i then
      gfx.set(1, 0.8, 0.2, 1) -- gold highlight
      gfx.circle(nodeX, nodeY, NODE_RADIUS + 5, true)
    end

    gfx.set(0.2, 0.4, 0.8, 1)
    gfx.circle(nodeX, nodeY, NODE_RADIUS, true)
    gfx.set(1, 1, 1, 1)
    gfx.circle(nodeX, nodeY, NODE_RADIUS, false)

    local label = chord.name .. getChordSuffix()
    local strW, strH = gfx.measurestr(label)
    gfx.x = nodeX - strW / 2
    gfx.y = nodeY - strH / 2
    gfx.drawstr(label)
  end

  -- Status message
  gfx.set(1, 1, 1, 1)
  gfx.setfont(1, "Arial", 14)
  gfx.x = 20
  gfx.y = WINDOW_H - 40
  gfx.drawstr(statusMessage)
end

--------------------------------------------------------------------------
-- Input handling
--------------------------------------------------------------------------
local function checkClicks()
  local mouseDown = gfx.mouse_cap & 1 == 1
  local mouseX, mouseY = gfx.mouse_x, gfx.mouse_y

  if mouseDown and lastMouseState == 0 then
    -- CLEAR button
    if mouseX >= clearBtnX and mouseX <= clearBtnX + clearBtnW and
       mouseY >= clearBtnY and mouseY <= clearBtnY + clearBtnH then
      clearAllChords()
      lastMouseState = 1
      return
    end

    -- MODE toggle button
    if mouseX >= modeBtnX and mouseX <= modeBtnX + modeBtnW and
       mouseY >= modeBtnY and mouseY <= modeBtnY + modeBtnH then
      isMinorMode = not isMinorMode
      lastMouseState = 1
      return
    end

    -- 7TH toggle button
    if mouseX >= seventhBtnX and mouseX <= seventhBtnX + seventhBtnW and
       mouseY >= seventhBtnY and mouseY <= seventhBtnY + seventhBtnH then
      use7th = not use7th
      lastMouseState = 1
      return
    end

    -- Circle nodes (chords)
    for i, chord in ipairs(circleOfFifths) do
      local angle = (i - 1) * (2 * math.pi / 12) - math.pi / 2
      local nodeX = CENTER_X + RADIUS * math.cos(angle)
      local nodeY = CENTER_Y + RADIUS * math.sin(angle)
      local dist = math.sqrt((mouseX - nodeX)^2 + (mouseY - nodeY)^2)

      if dist <= NODE_RADIUS then
        local intervals = getIntervals()
        local chordName = chord.name .. getChordSuffix()
        addChordToMidi(chord.root, intervals, chordName)
        lastClickedIndex = i
        lastMouseState = 1
        return
      end
    end
  end

  if not mouseDown then
    lastMouseState = 0
  else
    lastMouseState = 1
  end
end

--------------------------------------------------------------------------
-- Main loop
--------------------------------------------------------------------------
local function mainLoop()
  draw()
  checkClicks()

  local char = gfx.getchar()
  if char >= 0 then
    reaper.defer(mainLoop)
  else
    reaper.UpdateArrange()
  end
end

--------------------------------------------------------------------------
-- Init
--------------------------------------------------------------------------
local function init()
  reaper.Undo_BeginBlock()

  gfx.init("Chord Progression Generator", WINDOW_W, WINDOW_H, 0, 100, 100)
  gfx.setfont(1, "Arial", 16)

  getOrCreateMidiItem()
  currentPositionPPQ = 0

  if mediaItem then
    reaper.SelectAllMediaItems(0, false)
    reaper.SetMediaItemSelected(mediaItem, true)
    reaper.Main_OnCommand(40153, 0) -- Open in built-in MIDI editor
  end

  mainLoop()

  reaper.Undo_EndBlock("Chord Progression Generator", -1)
end

init()
