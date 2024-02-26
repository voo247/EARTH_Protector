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
    local fan1 = display.newImage("image/선풍기/선풍기1.png")
    fan1.height = 500
    fan1.width = 520
    fan1.x, fan1.y = display.contentHeight*0.9, display.contentWidth*0.3
    fan2 = display.newImage("image/선풍기/선풍기2.png")
    fan2.height = 0
    fan2.width = 0
    fan3 = display.newImage("image/선풍기/선풍기3.png")
    fan3.height = 0
    fan3.width = 0
    fan4 = display.newImage("image/선풍기/선풍기4.png")
    fan4.height = 0
    fan4.width = 0

    local function tapEvent1( event )
        fan2.height = 500
        fan2.width = 520
        fan2.x, fan2.y = display.contentHeight*0.9, display.contentWidth*0.3
        display.remove(fan1)
    end
    fan1:addEventListener("tap", tapEvent1)

    local function tapEvent2( event )
        fan3.height = 500
        fan3.width = 520
        fan3.x, fan3.y = display.contentHeight*0.9, display.contentWidth*0.3
        display.remove(fan2)
    end
    fan2:addEventListener("tap", tapEvent2)

    local function questEnd(event)
        display.remove(background)
        display.remove(title)
        display.remove(fan4)

        scene:destroy()
        composer.removeScene("quest_turnoff_fan")
        composer.gotoScene("game")
    end

    local function tapEvent3( event )
        local timeAttack = timer.performWithDelay(1000, questEnd)
        fan4.height = 500
        fan4.width = 520
        fan4.x, fan4.y = display.contentHeight*0.9, display.contentWidth*0.3
        display.remove(fan3)

    end
    fan3:addEventListener("tap", tapEvent3)
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
