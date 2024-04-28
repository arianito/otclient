local moduleManagerButton
local moduleJumpWindow
local moduleJumpButton
local yPos = 0
local xPos = 0
-- check for window being shown

function init()
  -- create a new window
  moduleJumpWindow = g_ui.displayUI('jumpgame')
  moduleJumpButton = moduleJumpWindow:getChildById('jumpButton')
  hide()

  moduleManagerButton = modules.client_topmenu.addRightButton('jumpgamebutton', 'Jump', '/images/game/states/slowed.png', toggle)
end

function terminate()
  moduleManagerButton:destroy()
  moduleJumpWindow:destroy()
end


function jump()
  xPos = 0
  yPos = math.random(0, moduleJumpWindow:getSize().height - 60)
end

function update_value()
  xPos = xPos + 10
  if xPos > moduleJumpWindow:getSize().width - 100 then
    jump()
  end

  moduleJumpButton:setMargin(yPos, xPos, 0, 0)

  -- repeat the process only if the window is visible
  if moduleJumpWindow:isVisible() then
    scheduleEvent(update_value, 100)
  end
end

function hide()
  moduleJumpWindow:hide()
end

function show()
  moduleJumpWindow:show()
  moduleJumpWindow:raise()
  moduleJumpWindow:focus()
  update_value()
end

function toggle()
  if moduleJumpWindow:isVisible() then
    hide()
  else
    show()
  end
end