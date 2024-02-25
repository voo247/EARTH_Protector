-----------------------------------------------------------------------------------------
--
-- 전기 스위치 끄기.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	--- 타이머 추가 -----------
	local time= display.newText(75, display.contentWidth*0.37, display.contentHeight*0.1)
 	time.size = 100
 	time:setFillColor(0)

	-----배경-----
	local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
    background.strokeWidth = 10
    background:setStrokeColor( 0.6 )
    background:setFillColor(1, 1, 0.9 )

    local title = display.newText("전기 스위치를 꺼 주세요!", display.contentWidth/2, display.contentHeight*0.2)
    title:setFillColor( 0 )
    title.size = 70

 	---스위치----------
 	local switchOn = display.newImage("image/퀘스트_자전거_스위치/스위치1.png")
 	switchOn.height = 500
 	switchOn.width = 350
 	switchOn.x, switchOn.y = display.contentHeight*0.9, display.contentWidth*0.3

 	function tapEvent1( event )
 		local switchOff = display.newImage("image/퀘스트_자전거_스위치/스위치2.png")
 		switchOff.height = 500
 		switchOff.width = 350
 		switchOff.x, switchOff.y = display.contentHeight*0.9, display.contentWidth*0.3
 	end
 	switchOn:addEventListener("tap", tapEvent1)



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
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
