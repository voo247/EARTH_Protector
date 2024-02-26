-----------------------------------------------------------------------------------------
--
-- 전기 스위치 끄기.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
 	---배경-----------------
	local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
    background.strokeWidth = 10
    background:setStrokeColor( 0.6 )
    background:setFillColor(1, 1, 0.9 )

    local title = display.newText("전기 스위치를 꺼 주세요!", display.contentWidth/2, display.contentHeight*0.2)
    title:setFillColor( 0 )
    title.size = 70

    ---스위치 끄기 퀘스트----------
 	local switchOn = display.newImage("image/퀘스트_자전거_스위치/스위치1.png")
 	switchOn.height = 500
 	switchOn.width = 350
 	switchOn.x, switchOn.y = display.contentHeight*0.9, display.contentWidth*0.3
 	
 	local switchOff

 	 	----------퀘스트 완료 후에 종료----------
    local function questEnd(event)
    	display.remove(background)
        display.remove(title)
        display.remove(switchOn)
        display.remove(switchOff)

        scene:destroy()
       	composer.removeScene("light_off_game")
       	composer.gotoScene("game")
    end
 
 	function tapEvent1( event )
 		local timeAttack = timer.performWithDelay(1000, questEnd)
 		switchOff = display.newImage("image/퀘스트_자전거_스위치/스위치2.png")
 		switchOff.height = 500
 		switchOff.width = 350
 		switchOff.x, switchOff.y = display.contentHeight*0.9, display.contentWidth*0.3
 	end
 	switchOn:addEventListener("tap", tapEvent1)
end

function scene:destroy( event )
    local sceneGroup = self.view
    
    local event = { name = "questEnd" }
    Runtime:dispatchEvent(event)
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
