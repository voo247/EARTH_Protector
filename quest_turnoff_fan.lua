-----------------------------------------------------------------------------------------
--
-- 선풍기 끄기.lua
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

    local title = display.newText("선풍기를 꺼 주세요!", display.contentWidth/2, display.contentHeight*0.2, "source/나눔손글씨 신혼부부.ttf")
    title:setFillColor( 0 )
    title.size = 70

    ---선풍기 끄기 퀘스트----------
    local button1 = display.newRect(display.contentCenterX, display.contentCenterY, 30, 30)
    button1.x = button1.x - 95
    button1.y = button1.y + 240

    local button2 = display.newRect(display.contentCenterX, display.contentCenterY, 80, 30)
    button2.x = button2.x + 210
    button2.y = button2.y + 70
    button2:setFillColor(0,0,1)

    local button3 = display.newRect(display.contentCenterX, display.contentCenterY, 80, 70)
    button3.x = button3.x + 210
    button3.y = button3.y + 120
    button3:setFillColor(0,0,1)
        print("button2 enabled")

    local b1 = false;
    local b2 = false;
    --local b3 = false;

    local fan = display.newImage("image/선풍기/선풍기1.png")
    fan.height = 500
    fan.width = 520
    fan.x, fan.y = display.contentHeight*0.9, display.contentWidth*0.3


    local function tapEvent1( event )        
            fan:removeSelf()
            fan = display.newImage("image/선풍기/선풍기2.png")
            fan.height = 500
            fan.width = 520
            fan.x, fan.y = display.contentHeight*0.9, display.contentWidth*0.3
            b1 = true
    end
    button1:addEventListener("tap", tapEvent1)

    local function tapEvent2( event )
        if b1 == true then
        fan:removeSelf()
        fan = display.newImage("image/선풍기/선풍기3.png")
        fan.height = 500
        fan.width = 520
        fan.x, fan.y = display.contentHeight*0.9, display.contentWidth*0.3
        b2 = true
        end
    end
    button2:addEventListener("tap", tapEvent2)

    function questEnd(event)
        display.remove(background)
        display.remove(title)
        display.remove(fan)
        display.remove(button1)
        display.remove(button2)
        display.remove(button3)

        scene:destroy()
        composer.removeScene("quest_turnoff_fan")
        composer.gotoScene("game")
    end

    local function tapEvent3( event )
        if b2 == true then
        local timeAttack = timer.performWithDelay(1000, questEnd)
        fan:removeSelf()
        fan = display.newImage("image/선풍기/선풍기4.png")
        fan.height = 500
        fan.width = 520
        fan.x, fan.y = display.contentHeight*0.9, display.contentWidth*0.3
        end
    end
    button3:addEventListener("tap", tapEvent3)
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
