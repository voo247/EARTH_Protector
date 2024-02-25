local fanImage1
local fanImage2
local fanImage3
local fanImage4
local fanState = 0  -- 선풍기 클릭 횟수

function love.load()
    -- 이미지 로드
    fanImage1 = love.graphics.newImage("선풍기1.png")
    fanImage2 = love.graphics.newImage("선풍기2.png")
    fanImage3 = love.graphics.newImage("선풍기3.png")
    fanImage4 = love.graphics.newImage("선풍기4.png")
end

function love.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local fanWidth = fanImage1:getWidth()  -- 선풍기 이미지의 너비
    local fanHeight = fanImage1:getHeight()  -- 선풍기 이미지의 높이

    -- 클릭 횟수에 따라 적절한 이미지를 표시
    if fanState == 0 then
        love.graphics.draw(fanImage1, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    elseif fanState == 1 then
        love.graphics.draw(fanImage2, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    elseif fanState == 2 then
        love.graphics.draw(fanImage3, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    elseif fanState == 3 then
        love.graphics.draw(fanImage4, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- 선풍기 버튼을 클릭한 경우
    if button == 1 then  -- 좌클릭인 경우
        fanState = (fanState + 1) % 4
        print("클릭 횟수:", fanState)
    end
end
