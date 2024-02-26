-----------------------------------------------------------------------------------------
--
-- questTemp.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
	--- 배경 ----------------------
 	local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
 	background.strokeWidth = 10
	background:setStrokeColor( 0.6 )
 	background:setFillColor(1, 1, 0.9 )

 	local title = display.newText("에어컨 온도 조절", display.contentWidth/2, display.contentHeight*0.2, "source/나눔손글씨 신혼부부.ttf")
 	title:setFillColor( 0.6 )
 	title.size = 70

 	--- 에어컨 ---------------------
 	local air = display.newImage("image/에어컨/에어컨.png", display.contentWidth/2, display.contentHeight*0.53)
 	air.height, air.width = air.height * 1.6, air.width * 1.6
 	local n_air = display.newImage("image/에어컨/에어컨_꺼짐.png", display.contentWidth/2, display.contentHeight*0.53)
    n_air.height, n_air.width = n_air.height * 1.6, n_air.width * 1.6

 	--- 초기 숫자 ------------------
 	local numberText = display.newText("", display.contentWidth*0.45, display.contentHeight*0.735, "source/나눔손글씨 신혼부부.ttf")
 	numberText:setFillColor( 0.3 )
 	numberText.size = 50

 	local randomNumber = math.random(15, 24) -- 15부터 24까지의 랜덤 숫자 생성
 	if(randomNumber == 26) then
 		randomNumber = math.random(15, 24)
 	end

    numberText.text = randomNumber

    --- 온도 조절하기 --------------

    local function Tap_temp(event)
	    if event.y < display.contentHeight*0.75 then 
	        numberText.text = numberText.text + 0.5
	    else
	        numberText.text = numberText.text - 0.5 
	    end
	end

	air:addEventListener("tap", Tap_temp)

	--- 게임 종료 ------------------

	local function questEnd(event)
        if(numberText.text == "26") then
        	display.remove(air)
        	numberText:setFillColor( 0.9, 0, 0.1 )

        	timer.performWithDelay(1000, function()
            	display.remove(background)
            	display.remove(title)
            	display.remove(numberText)
            	display.remove(n_air)
        	end)

        	

        	scene:destroy()
            composer.removeScene("questTemp")
            composer.gotoScene("game")
        end
    end

    Runtime:addEventListener("enterFrame", questEnd)
 	
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