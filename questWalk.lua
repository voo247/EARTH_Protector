-- 일반 퀘스트 6번 실행 : 걷기 --

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	physics.start()
	physics.setDrawMode("hybrid")

    -- 플레이어 캐릭터 위치 실시간으로 전달받기(다리 중심) --
    local pX, pY
    local function updatePlayerPosition(event)
        if event.name == "playerPositionUpdate" then
            pX = event.x
            pY = event.y + 100
        end
    end
    
    Runtime:addEventListener("playerPositionUpdate", updatePlayerPosition)
	
    -- 경로 회색선 --
    local line = display.newLine(
        display.contentWidth*0.568, display.contentHeight*0.325, 
        display.contentWidth*0.29, display.contentHeight*0.325, 
        display.contentWidth*0.29, display.contentHeight*0.552, 
        display.contentWidth*0.715, display.contentHeight*0.552, 
        display.contentWidth*0.715, display.contentHeight*0.84)
    line.strokeWidth = 120
    line:setStrokeColor(0.5, 0.5, 0.5)
    line.alpha = 0.6

    -- 삼각형 --
    local points = {
        {x = display.contentWidth*0.54, y = display.contentHeight*0.325},
        {x = display.contentWidth*0.29, y = display.contentHeight*0.325},
        {x = display.contentWidth*0.29, y = display.contentHeight*0.552},
        {x = display.contentWidth*0.715, y = display.contentHeight*0.552},
        {x = display.contentWidth*0.715, y = display.contentHeight*0.79}
    }
    
    local triangleDirections = {"left", "down", "right", "down"}
    local triangles = {}

    for i = 1, #points - 1 do
        local x1, y1 = points[i].x, points[i].y
        local x2, y2 = points[i + 1].x, points[i + 1].y

        local dx = x2 - x1
        local dy = y2 - y1
        local length = math.sqrt(dx*dx + dy*dy)

        local nx = dx / length
        local ny = dy / length

        for j = 0, length, 82 do
            local x = x1 + nx * j
            local y = y1 + ny * j

            local trianglePoints
            if triangleDirections[i] == "right" then
                trianglePoints = {30 * 0.5, 0, -30 * 0.5, -30 * 0.5, -30 * 0.5, 30 * 0.5}
            elseif triangleDirections[i] == "down" then
                trianglePoints = {0, 30 * 0.5, -30 * 0.5, -30 * 0.5, 30 * 0.5, -30 * 0.5}
            elseif triangleDirections[i] == "left" then
                trianglePoints = {-30 * 0.5, 0, 30 * 0.5, -30 * 0.5, 30 * 0.5, 30 * 0.5}
            end

            for j = 0, length, 82 do
                local triangle = display.newPolygon(x, y, trianglePoints)
                triangle:setFillColor(1, 1, 1)
            
                table.insert(triangles, triangle)
            end
        end
    end

    -- 리스타트(다시 시작점으로) --
    local function restart()
        local restart = { name = "restart" }
        Runtime:dispatchEvent(restart)
    end

    local q6ing = true

    -- 미니게임 종료 --
    local function questEnd()
        q6ing = false
        display.remove(line)
        for i = #triangles, 1, -1 do
            display.remove(triangles[i])
            table.remove(triangles, i)
        end

        scene:destroy()
        composer.removeScene("questWalk")
        composer.gotoScene("game")
    end

    -- 길을 벗어나는지 체크 --
    local function isPCOnLine(event)
        if (display.contentWidth*0.715 - 60 < pX and pX < display.contentWidth*0.715 + 60
        and display.contentHeight*0.8 - 60 < pY and pY < display.contentHeight*0.8 + 60) then
            questEnd()
        elseif q6ing then
            local tolerance = 70
            if (display.contentWidth*0.553 - tolerance <= pX and pX <= display.contentWidth*0.583 + tolerance and
            display.contentHeight*0.30 - tolerance <= pY and pY <= display.contentHeight*0.35 + tolerance) then
                --print("GAME START")
            elseif (display.contentWidth*0.29 - tolerance <= pX and pX <= display.contentWidth*0.568 + tolerance and
            display.contentHeight*0.325 - tolerance <= pY and pY <= display.contentHeight*0.325 + tolerance) then
                --print("PC on 1 LINE")
            elseif (display.contentWidth*0.29 - tolerance <= pX and pX <= display.contentWidth*0.29 + tolerance and
            display.contentHeight*0.325 - tolerance <= pY and pY <= display.contentHeight*0.552 + tolerance) then
                --print("PC on 2 LINE")
            elseif (display.contentWidth*0.29 - tolerance <= pX and pX <= display.contentWidth*0.715 + tolerance and
            display.contentHeight*0.552 - tolerance <= pY and pY <= display.contentHeight*0.552 + tolerance) then
                --print("PC on 3 LINE")
            elseif (display.contentWidth*0.715 - tolerance <= pX and pX <= display.contentWidth*0.715 + tolerance and
            display.contentHeight*0.552 - tolerance <= pY and pY <= display.contentHeight*0.84 + tolerance) then
                --print("PC on 4 LINE")
            else
                --print("PC not on LINE")
                restart()
            end
        end
    end

    Runtime:addEventListener("enterFrame", isPCOnLine)
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
