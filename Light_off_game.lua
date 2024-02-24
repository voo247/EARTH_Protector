-----------------------------------------------------------------------------------------
--
-- 전기 스위치 끄기.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
local background = display.newImageRect("image/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--- 타이머 추가 -----------
	local time= display.newText(75, display.contentWidth*0.37, display.contentHeight*0.1)
 	time.size = 100
 	time:setFillColor(0)

 	---스위치----------
 	local switchOn = display.newImage("image/스위치1.png")
 	switchOn.height = 500
 	switchOn.width = 350
 	switchOn.x, switchOn.y = display.contentHeight*0.9, display.contentWidth*0.3

 	function tapEvent1( event )
 		local switchOff = display.newImage("image/스위치2.png")
 		switchOff.height = 500
 		switchOff.width = 350
 		switchOff.x, switchOff.y = display.contentHeight*0.9, display.contentWidth*0.3
 	end
 	switchOn:addEventListener("tap", tapEvent1)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
