-- autostart hydra
autolaunch.set(true)

-- watch for changes
pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()

-- notify on start
hydra.alert "Hydra, at your service."

-- Cached window positions
local positions = {
  fullscreen = {},
  snap = {},
}

function copyframe(frame)
  local copy = {}

  for key, value in pairs(frame) do
    copy[key] = value
  end

  return copy
end

function issameframe(frame1, frame2)
  if frame1.x ~= frame2.x then
    return false
  end

  if frame1.y ~= frame2.y then
    return false
  end

  if frame1.w ~= frame2.w then
    return false
  end

  if frame1.h ~= frame2.h then
    return false
  end

  return true
end

-- Check if a window is fullscreen
function isfullscreen(win)
  return issameframe(win:frame(), win:screen():frame_without_dock_or_menu())
end

-- center inside screen
function centerframe(screen, frame)
  frame.x = screen.w / 2 - frame.w / 2 + screen.x
  frame.y = screen.h / 2 - frame.h / 2 + screen.y

  return frame
end

-- center given window
function centerwindow(win)
  local screen = win:screen():frame_without_dock_or_menu()
  local frame = win:frame()

  frame.w = screen.w * 5 / 6
  frame.h = screen.h * 5 / 6

  win:setframe(centerframe(screen, frame))
end

-- Toggle maximized state of window
function togglemaximized(win)
  local id = string.lower(string.gsub(win:application():bundleid(), "%W", ""))

  if isfullscreen(win) then
    if positions["fullscreen"][id] then
      win:setframe(positions["fullscreen"][id])
    else
      centerwindow(win)
    end
  else
    positions["fullscreen"][id] = win:frame()
    win:maximize()
  end
end

local snaps = {}
local snapstates = {
  right = {
    right1 = "right2",
    right2 = "right3",
    right3 = "right4",
    right4 = "right1",
  },
  left = {
    left1 = "left2",
    left2 = "left3",
    left3 = "left4",
    left4 = "left1",
  },
}

function isrestorable(win)
  local screen = win:screen():frame_without_dock_or_menu()
  local frame = win:frame()

  return frame.h < screen.h
end

function nextsnapstate(state, relativeto)
  local side = string.sub(state, 0, -2)
  local index = tonumber(string.sub(state, -1))

  if side == relativeto then
    return snapstates[side][state]
  else
    newstate = relativeto .. "1"

    if index == 4 then
      newstate = string.gsub(newstate, "1", "4")
    end

    return snapstates[relativeto][newstate]
  end
end

function updatesnapsavedposition(win, id)
  local frame = win:frame()

  if not positions["snap"][id] or (not issameframe(positions["snap"][id]["left"], frame) and not issameframe(positions["snap"][id]["right"], frame)) then
    local screen = win:screen():frame_without_dock_or_menu()

    positions["snap"][id] = { left = copyframe(frame), right = copyframe(frame) }
    positions["snap"][id]["right"]["x"] = frame.x
    positions["snap"][id]["left"]["x"] = screen.w - frame.x - frame.w
  end
end

function snapto(win, side)
  local id = string.lower(string.gsub(win:application():bundleid(), "%W", ""))
  local screen = win:screen():frame_without_dock_or_menu()
  local frame = win:frame()
  local snapstate = side .. "1"
  local previoussnap = snaps[id]

  if previoussnap then
    snapstate = nextsnapstate(previoussnap, side)
  end

  if not isfullscreen(win) and isrestorable(win) then
    updatesnapsavedposition(win, id)

    if issameframe(frame, positions["snap"][id][side]) then
      snapstate = side .. "1"
    else
      local previousside = string.sub(previoussnap, 0, -2)

      if previousside ~= side then
        snapstate = side .. "4"
      end
    end
  end

  local index = tonumber(string.sub(snapstate, -1))

  if index == 4 and positions["snap"][id] then
    frame = positions["snap"][id][side]
  else
    if index == 4 or (index == 1 and frame.w == screen.w * 2 / 3) then
      snapstate = nextsnapstate(snapstate, side)
      index = tonumber(string.sub(snapstate, -1))
    end

    if index == 1 then
      frame.w = screen.w * 2 / 3
    elseif index == 2 then
      frame.w = screen.w / 2
    elseif index == 3 then
      frame.w = screen.w * 3 / 4
    end

    if side == "right" then
      frame.x = screen.w - frame.w
    elseif side == "left" then
      frame.x = screen.x
    end

    frame.y = screen.y
    frame.h = screen.h
  end

  snaps[id] = snapstate

  win:setframe(frame)
end

-- Snap window to the right
-- while switching between 3 sizes
function snapright(win)
  snapto(win, "right")
end

-- Snap window to the left
-- while switching between 3 sizes
function snapleft(win)
  snapto(win, "left")
end

-- save the time when updates are checked
function checkforupdates()
  updates.check()
  settings.set('lastcheckedupdates', os.time())
end

-- show available updates
local function showupdate()
  os.execute('open https://github.com/sdegutis/Hydra/releases')
end

-- what to do when an udpate is checked
function updates.available(available)
  if available then
    notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
  else
    hydra.alert("No update available.")
  end
end

-- check for updates every week
timer.new(timer.days(1), checkforupdates):start()
notify.register("showupdate", showupdate)

-- if this is your first time running Hydra, you're launching it more than a week later, check now
local lastcheckedupdates = settings.get('lastcheckedupdates')
if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
  checkforupdates()
end

menu.show(function()
  local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
  local updatefns = {[true] = updates.install, [false] = checkforupdates}
  local hasupdate = (updates.newversion ~= nil)

  return {
    {title = "About", fn = hydra.showabout},
    {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
    {title = "-"},
    {title = "Reload Config", fn = hydra.reload},
    {title = "-"},
    {title = "Quit Hydra", fn = os.exit},
  }
end)

local mash = {"cmd", "alt", "ctrl"}

hotkey.bind(mash, "M", function() togglemaximized(window.focusedwindow()) end)
hotkey.bind(mash, "right", function() snapright(window.focusedwindow()) end)
hotkey.bind(mash, "left", function() snapleft(window.focusedwindow()) end)



















-- menu.show(function()
--     return {
--       {title = "About Hydra", fn = hydra.showabout},
--       {title = "-"},
--       {title = "Quit", fn = os.exit},
--     }
-- end)

-- local mash = {"cmd", "alt", "ctrl"}

-- hotkey.bind(mash, 'M', ext.grid.maximize_window)

-- hotkey.bind(mash, 'J', ext.grid.pushwindow_down)
-- hotkey.bind(mash, 'K', ext.grid.pushwindow_up)
-- hotkey.bind(mash, 'H', ext.grid.pushwindow_left)
-- hotkey.bind(mash, 'L', ext.grid.pushwindow_right)

-- hotkey.bind(mash, 'U', ext.grid.resizewindow_taller)
-- hotkey.bind(mash, 'O', ext.grid.resizewindow_wider)
-- hotkey.bind(mash, 'I', ext.grid.resizewindow_thinner)

-- updates.check()
