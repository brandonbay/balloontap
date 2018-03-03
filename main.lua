-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tapCount = 0
local best = 0

local background = display.newImageRect('background.png', 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText( tapCount, display.contentCenterX, 30, native.systemFont, 40 )
tapText:setFillColor( 0, 0, 0 )

local bestText = display.newText( 'Best: 0', display.contentCenterX, 0, native.systemFont, 20 )
bestText:setFillColor( 0, 0, 0 )


local platform = display.newImageRect('platform.png', 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect( "balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require('physics')
physics.start()

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )

local function pushBalloon()
  balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
  tapCount = tapCount + 1
  tapText.text = tapCount

  if best < tapCount then
    best = tapCount
    bestText.text = 'Best: ' .. best
  end
end

local function balloonCollision(self, event)
  if (event.other == platform) then
    tapCount = 0
    tapText.text = tapCount
  end
end

balloon:addEventListener( 'tap', pushBalloon )
balloon.collision = balloonCollision
balloon:addEventListener( 'collision' )
