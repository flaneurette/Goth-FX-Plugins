-- ============================================================
-- 1) GENERAL MIDI DRUM NOTE NUMBERS (for readability)
-- ============================================================
local KICK   = 36
local SNARE  = 38
local CLAP   = 39
local CHH    = 42 -- closed hihat
local OHH    = 46 -- open hihat
local RIDE   = 51
local CRASH  = 49
local LOWTOM = 45
local HITOM  = 48

-- ============================================================
-- 2) DRUM PATTERNS  (this is the array you extend later)
-- ============================================================
local patterns = {

  {
    name = "Basic Rock Beat",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 100, 1 }, { KICK, 8, 100, 1 },
      { SNARE, 4, 110, 1 }, { SNARE, 12, 110, 1 },
      { CHH, 0, 80, 1 }, { CHH, 2, 70, 1 }, { CHH, 4, 80, 1 }, { CHH, 6, 70, 1 },
      { CHH, 8, 80, 1 }, { CHH, 10, 70, 1 }, { CHH, 12, 80, 1 }, { CHH, 14, 70, 1 },
    }
  },

  {
    name = "Four on the Floor",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 4, 110, 1 }, { KICK, 8, 110, 1 }, { KICK, 12, 110, 1 },
      { CLAP, 4, 100, 1 }, { CLAP, 12, 100, 1 },
      { CHH, 2, 70, 1 }, { CHH, 6, 70, 1 }, { CHH, 10, 70, 1 }, { CHH, 14, 70, 1 },
    }
  },

  {
    name = "Boom Bap",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 10, 90, 1 },
      { SNARE, 4, 110, 1 }, { SNARE, 12, 110, 1 },
      { CHH, 0, 70, 1 }, { CHH, 2, 60, 1 }, { CHH, 4, 70, 1 }, { CHH, 6, 60, 1 },
      { CHH, 8, 70, 1 }, { CHH, 10, 60, 1 }, { CHH, 12, 70, 1 }, { CHH, 14, 60, 1 },
    }
  },

  {
    name = "Half-Time Groove",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 6, 90, 1 }, { KICK, 10, 100, 1 },
      { SNARE, 8, 115, 1 },
      { CHH, 0, 70, 1 }, { CHH, 2, 60, 1 }, { CHH, 4, 70, 1 }, { CHH, 6, 60, 1 },
      { CHH, 8, 70, 1 }, { CHH, 10, 60, 1 }, { CHH, 12, 70, 1 }, { CHH, 14, 60, 1 },
      { OHH, 14, 80, 1 },
    }
  },

  {
    name = "Disco",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 4, 110, 1 }, { KICK, 8, 110, 1 }, { KICK, 12, 110, 1 },
      { SNARE, 4, 100, 1 }, { SNARE, 12, 100, 1 },
      { OHH, 2, 80, 1 }, { OHH, 6, 80, 1 }, { OHH, 10, 80, 1 }, { OHH, 14, 80, 1 },
    }
  },

  {
    name = "Driving Rock Beat",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 105, 1 }, { KICK, 6, 90, 1 }, { KICK, 8, 105, 1 }, { KICK, 10, 85, 1 },
      { SNARE, 4, 115, 1 }, { SNARE, 12, 115, 1 },
      { CHH, 0, 85, 1 }, { CHH, 2, 75, 1 }, { CHH, 4, 85, 1 }, { CHH, 6, 75, 1 },
      { CHH, 8, 85, 1 }, { CHH, 10, 75, 1 }, { CHH, 12, 85, 1 }, { CHH, 14, 75, 1 },
    }
  },

  {
    name = "Hard Rock Stomp",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 3, 90, 1 }, { KICK, 8, 110, 1 }, { KICK, 11, 90, 1 },
      { SNARE, 4, 120, 1 }, { SNARE, 12, 120, 1 },
      { CHH, 0, 90, 1 }, { CHH, 2, 80, 1 }, { CHH, 4, 90, 1 }, { CHH, 6, 80, 1 },
      { CHH, 8, 90, 1 }, { CHH, 10, 80, 1 }, { CHH, 12, 90, 1 }, { CHH, 14, 80, 1 },
      { CRASH, 0, 100, 1 },
    }
  },

  {
    name = "Gothic Doom March",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 115, 1 }, { KICK, 6, 100, 1 }, { KICK, 8, 115, 1 }, { KICK, 14, 100, 1 },
      { SNARE, 4, 100, 1 }, { SNARE, 12, 100, 1 },
      { CHH, 0, 60, 1 }, { CHH, 4, 60, 1 }, { CHH, 8, 60, 1 }, { CHH, 12, 60, 1 },
      { CRASH, 0, 90, 1 },
      { LOWTOM, 14, 95, 1 }, { HITOM, 15, 95, 1 },
    }
  },

  {
    name = "Gothic Ritual (Half-Time)",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 8, 90, 1 },
      { SNARE, 8, 115, 1 },
      { CHH, 0, 55, 1 }, { CHH, 4, 55, 1 }, { CHH, 8, 55, 1 }, { CHH, 12, 55, 1 },
      { HITOM, 12, 90, 1 }, { LOWTOM, 14, 90, 1 },
      { CRASH, 0, 85, 1 },
    }
  },

  {
    name = "Gothic Industrial Pulse",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 120, 1 }, { KICK, 2, 100, 1 }, { KICK, 4, 120, 1 }, { KICK, 6, 100, 1 },
      { KICK, 8, 120, 1 }, { KICK, 10, 100, 1 }, { KICK, 12, 120, 1 }, { KICK, 14, 100, 1 },
      { SNARE, 4, 105, 1 }, { SNARE, 12, 105, 1 },
      { CHH, 0, 70, 1 }, { CHH, 2, 70, 1 }, { CHH, 4, 70, 1 }, { CHH, 6, 70, 1 },
      { CHH, 8, 70, 1 }, { CHH, 10, 70, 1 }, { CHH, 12, 70, 1 }, { CHH, 14, 70, 1 },
    }
  },
  {
    name = "Gothic Waltz",
    steps_per_beat = 4,
    length_beats = 3,
    notes = {
      { KICK, 0, 105, 1 }, { KICK, 8, 90, 1 },
      { SNARE, 4, 95, 1 },
      { CRASH, 0, 80, 1 },
      { CHH, 4, 55, 1 }, { CHH, 8, 55, 1 },
    }
  },

  {
    name = "Gothic Funeral Dirge",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 100, 1 }, { KICK, 8, 100, 1 },
      { LOWTOM, 4, 90, 1 }, { HITOM, 12, 90, 1 },
      { CRASH, 0, 75, 1 },
      { CHH, 0, 40, 1 }, { CHH, 8, 40, 1 },
    }
  },
  {
    name = "Ballad Slow Groove",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 90, 1 }, { KICK, 10, 80, 1 },
      { SNARE, 8, 95, 1 },
      { CHH, 0, 50, 1 }, { CHH, 4, 50, 1 }, { CHH, 8, 50, 1 }, { CHH, 12, 50, 1 },
      { RIDE, 0, 60, 1 }, { RIDE, 4, 60, 1 }, { RIDE, 8, 60, 1 }, { RIDE, 12, 60, 1 },
    }
  },

  {
    name = "Ballad with Ghost Snare",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 85, 1 }, { KICK, 8, 85, 1 },
      { SNARE, 4, 90, 1 }, { SNARE, 6, 40, 1 },
      { SNARE, 12, 90, 1 }, { SNARE, 14, 40, 1 },
      { RIDE, 0, 55, 1 }, { RIDE, 2, 45, 1 }, { RIDE, 4, 55, 1 }, { RIDE, 6, 45, 1 },
      { RIDE, 8, 55, 1 }, { RIDE, 10, 45, 1 }, { RIDE, 12, 55, 1 }, { RIDE, 14, 45, 1 },
    }
  },

  {
    name = "Power Ballad Build",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 95, 1 }, { KICK, 6, 80, 1 }, { KICK, 8, 95, 1 }, { KICK, 14, 80, 1 },
      { SNARE, 4, 100, 1 }, { SNARE, 12, 100, 1 },
      { CHH, 0, 65, 1 }, { CHH, 2, 55, 1 }, { CHH, 4, 65, 1 }, { CHH, 6, 55, 1 },
      { CHH, 8, 65, 1 }, { CHH, 10, 55, 1 }, { CHH, 12, 65, 1 }, { CHH, 14, 55, 1 },
      { HITOM, 15, 85, 1 },
    }
  },

  {
    name = "Ballad 6/8 Sway",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 90, 1 }, { KICK, 6, 80, 1 }, { KICK, 8, 90, 1 }, { KICK, 14, 80, 1 },
      { SNARE, 4, 95, 1 }, { SNARE, 12, 95, 1 },
      { RIDE, 0, 55, 1 }, { RIDE, 2, 45, 1 }, { RIDE, 4, 55, 1 }, { RIDE, 6, 45, 1 },
      { RIDE, 8, 55, 1 }, { RIDE, 10, 45, 1 }, { RIDE, 12, 55, 1 }, { RIDE, 14, 45, 1 },
    }
  },

  {
    name = "Anthemic Rock Chorus",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 110, 1 }, { KICK, 4, 110, 1 }, { KICK, 8, 110, 1 }, { KICK, 10, 90, 1 }, { KICK, 12, 110, 1 },
      { SNARE, 4, 115, 1 }, { SNARE, 12, 115, 1 },
      { CHH, 0, 85, 1 }, { CHH, 2, 75, 1 }, { CHH, 4, 85, 1 }, { CHH, 6, 75, 1 },
      { CHH, 8, 85, 1 }, { CHH, 10, 75, 1 }, { CHH, 12, 85, 1 }, { CHH, 14, 75, 1 },
      { CRASH, 0, 95, 1 },
    }
  },
  {
    name = "Funk Groove",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 100, 1 }, { KICK, 3, 80, 1 }, { KICK, 6, 90, 1 }, { KICK, 10, 100, 1 },
      { SNARE, 4, 105, 1 }, { SNARE, 12, 105, 1 },
      { CHH, 0, 75, 1 }, { CHH, 1, 50, 1 }, { CHH, 2, 75, 1 }, { CHH, 3, 50, 1 },
      { CHH, 4, 75, 1 }, { CHH, 5, 50, 1 }, { CHH, 6, 75, 1 }, { CHH, 7, 50, 1 },
      { CHH, 8, 75, 1 }, { CHH, 9, 50, 1 }, { CHH, 10, 75, 1 }, { CHH, 11, 50, 1 },
      { CHH, 12, 75, 1 }, { CHH, 13, 50, 1 }, { CHH, 14, 75, 1 }, { CHH, 15, 50, 1 },
    }
  },

  {
    name = "Blues Shuffle",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 100, 1 }, { KICK, 8, 100, 1 },
      { SNARE, 4, 105, 1 }, { SNARE, 12, 105, 1 },
      { CHH, 0, 80, 1 }, { CHH, 3, 60, 1 }, { CHH, 4, 80, 1 }, { CHH, 7, 60, 1 },
      { CHH, 8, 80, 1 }, { CHH, 11, 60, 1 }, { CHH, 12, 80, 1 }, { CHH, 15, 60, 1 },
    }
  },

  {
    name = "Latin Bossa Nova",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 90, 1 }, { KICK, 6, 85, 1 }, { KICK, 8, 90, 1 }, { KICK, 14, 85, 1 },
      { CLAP, 4, 85, 1 }, { CLAP, 12, 85, 1 },
      { RIDE, 0, 65, 1 }, { RIDE, 3, 55, 1 }, { RIDE, 4, 65, 1 }, { RIDE, 6, 55, 1 },
      { RIDE, 8, 65, 1 }, { RIDE, 11, 55, 1 }, { RIDE, 12, 65, 1 }, { RIDE, 14, 55, 1 },
    }
  },

  {
    name = "Latin Samba",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 100, 1 }, { KICK, 4, 90, 1 }, { KICK, 8, 100, 1 }, { KICK, 12, 90, 1 },
      { CLAP, 2, 85, 1 }, { CLAP, 6, 85, 1 }, { CLAP, 10, 85, 1 }, { CLAP, 14, 85, 1 },
      { CHH, 0, 70, 1 }, { CHH, 2, 70, 1 }, { CHH, 4, 70, 1 }, { CHH, 6, 70, 1 },
      { CHH, 8, 70, 1 }, { CHH, 10, 70, 1 }, { CHH, 12, 70, 1 }, { CHH, 14, 70, 1 },
    }
  },
      {
    name = "Punk Rock Thrash",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 115, 1 }, { KICK, 4, 115, 1 }, { KICK, 8, 115, 1 }, { KICK, 12, 115, 1 },
      { SNARE, 4, 120, 1 }, { SNARE, 12, 120, 1 },
      { CHH, 0, 90, 1 }, { CHH, 2, 90, 1 }, { CHH, 4, 90, 1 }, { CHH, 6, 90, 1 },
      { CHH, 8, 90, 1 }, { CHH, 10, 90, 1 }, { CHH, 12, 90, 1 }, { CHH, 14, 90, 1 },
    }
  },

  {
    name = "Metal Double Kick",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 120, 1 }, { KICK, 1, 110, 1 }, { KICK, 4, 120, 1 }, { KICK, 5, 110, 1 },
      { KICK, 8, 120, 1 }, { KICK, 9, 110, 1 }, { KICK, 12, 120, 1 }, { KICK, 13, 110, 1 },
      { SNARE, 4, 120, 1 }, { SNARE, 12, 120, 1 },
      { CHH, 0, 85, 1 }, { CHH, 2, 85, 1 }, { CHH, 4, 85, 1 }, { CHH, 6, 85, 1 },
      { CHH, 8, 85, 1 }, { CHH, 10, 85, 1 }, { CHH, 12, 85, 1 }, { CHH, 14, 85, 1 },
      { CRASH, 0, 100, 1 },
    }
  },

  {
    name = "Metal Blast Beat",
    steps_per_beat = 4,
    length_beats = 4,
    notes = {
      { KICK, 0, 120, 1 }, { KICK, 2, 120, 1 }, { KICK, 4, 120, 1 }, { KICK, 6, 120, 1 },
      { KICK, 8, 120, 1 }, { KICK, 10, 120, 1 }, { KICK, 12, 120, 1 }, { KICK, 14, 120, 1 },
      { SNARE, 0, 115, 1 }, { SNARE, 2, 115, 1 }, { SNARE, 4, 115, 1 }, { SNARE, 6, 115, 1 },
      { SNARE, 8, 115, 1 }, { SNARE, 10, 115, 1 }, { SNARE, 12, 115, 1 }, { SNARE, 14, 115, 1 },
    }
  },
  -- ---------------------------------------------------------------------
  -- ADD NEW PATTERNS HERE, following the exact same shape as above:
  --
  -- {
  --   name = "My New Pattern",
  --   steps_per_beat = 4,
  --   length_beats = 4,
  --   notes = {
  --     { KICK, 0, 100, 1 }, { SNARE, 4, 100, 1 },
  --   }
  -- },
  -- ---------------------------------------------------------------------
}

-- ============================================================
-- 3) MIDI-DRAWING LOGIC
-- ============================================================
local function draw_pattern_to_midi(pattern)
  reaper.Undo_BeginBlock()

  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.InsertTrackAtIndex(0, true)
    track = reaper.GetTrack(0, 0)
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "Drums", true)
    reaper.SetTrackSelected(track, true)
  end

  local cursor_pos = reaper.GetCursorPosition()
  local cursor_qn = reaper.TimeMap_timeToQN(cursor_pos)
  local end_qn = cursor_qn + pattern.length_beats
  local end_time = reaper.TimeMap_QNToTime(end_qn)

  local item = reaper.CreateNewMIDIItemInProj(track, cursor_pos, end_time, false)
  local take = reaper.GetMediaItemTake(item, 0)

  local step_len_beats = 1 / pattern.steps_per_beat

  for _, n in ipairs(pattern.notes) do
    local pitch, step, vel, dur_steps = n[1], n[2], n[3], n[4]
    local note_start_qn = cursor_qn + step * step_len_beats
    local note_end_qn = note_start_qn + dur_steps * step_len_beats
    local note_start_time = reaper.TimeMap_QNToTime(note_start_qn)
    local note_end_time = reaper.TimeMap_QNToTime(note_end_qn)
    local ppq_start = reaper.MIDI_GetPPQPosFromProjTime(take, note_start_time)
    local ppq_end = reaper.MIDI_GetPPQPosFromProjTime(take, note_end_time)
    -- channel 9 (0-indexed) = MIDI channel 10, the standard GM drum channel
    reaper.MIDI_InsertNote(take, false, false, ppq_start, ppq_end, 9, pitch, vel, true)
  end

  reaper.MIDI_Sort(take)

  reaper.SetMediaItemSelected(item, true)
  reaper.Main_OnCommand(40153, 0) -- Item: Open in built-in MIDI editor

  reaper.UpdateArrange()
  reaper.Undo_EndBlock("Draw drum pattern: " .. pattern.name, -1)
end

-- ============================================================
-- 4) TINY GUI (gfx) -- the "selectbox" + "Draw MIDI" button
-- ============================================================
local selected = 1
local mouse_last_down = false

local list_x, list_y = 10, 10
local list_w = 260
local item_h = 26

local function window_height()
  return list_y + (#patterns) * item_h + 20 + 34 + 20
end

local function draw_ui()
  gfx.set(0.15, 0.15, 0.17, 1)
  gfx.rect(0, 0, gfx.w, gfx.h, 1)

  gfx.setfont(1, "Arial", 16)

  for i, p in ipairs(patterns) do
    local y = list_y + (i - 1) * item_h
    if i == selected then
      gfx.set(0.25, 0.5, 0.85, 1)
    else
      gfx.set(0.22, 0.22, 0.25, 1)
    end
    gfx.rect(list_x, y, list_w, item_h - 4, 1)
    gfx.set(1, 1, 1, 1)
    gfx.x = list_x + 8
    gfx.y = y + 5
    gfx.drawstr(p.name)
  end

  local btn_y = list_y + (#patterns) * item_h + 20
  gfx.set(0.2, 0.6, 0.3, 1)
  gfx.rect(list_x, btn_y, list_w, 34, 1)
  gfx.set(1, 1, 1, 1)
  gfx.x = list_x + 78
  gfx.y = btn_y + 9
  gfx.drawstr("Draw MIDI")

  return btn_y
end

local function handle_mouse(btn_y)
  local mx, my = gfx.mouse_x, gfx.mouse_y
  local down = (gfx.mouse_cap & 1) == 1
  local clicked = down and not mouse_last_down
  mouse_last_down = down

  if clicked then
    for i, p in ipairs(patterns) do
      local y = list_y + (i - 1) * item_h
      if mx >= list_x and mx <= list_x + list_w and my >= y and my <= y + item_h - 4 then
        selected = i
      end
    end

    if mx >= list_x and mx <= list_x + list_w and my >= btn_y and my <= btn_y + 34 then
      draw_pattern_to_midi(patterns[selected])
    end
  end
end

local function main()
  local btn_y = draw_ui()
  handle_mouse(btn_y)
  gfx.update()
  if gfx.getchar() >= 0 then
    reaper.defer(main)
  end
end

gfx.init("Drum Pattern Drawer", list_w + 20, window_height())
main()
