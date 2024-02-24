local fanOnImage
local fanOffImage
local fanPressedImage
local fanState = "on"  -- 선풍기 상태: "on" / "off" / "pressed"

function love.load()
    -- 이미지 로드
    fanOnImage = love.graphics.newImage("fan_on.png")
    fanOffImage = love.graphics.newImage("fan_off.png")
    fanPressedImage = love.graphics.newImage("fan_pressed.png")
end

function love.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local fanWidth = fanOnImage:getWidth()  -- 선풍기 이미지의 너비
    local fanHeight = fanOnImage:getHeight()  -- 선풍기 이미지의 높이

    -- 선풍기 이미지를 화면 중앙에 표시
    if fanState == "on" then
        love.graphics.draw(fanOnImage, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    elseif fanState == "off" then
        love.graphics.draw(fanOffImage, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    elseif fanState == "pressed" then
        love.graphics.draw(fanPressedImage, (screenWidth - fanWidth) / 2, (screenHeight - fanHeight) / 2)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- 선풍기 버튼을 클릭한 경우
    if button == 1 then  -- 좌클릭인 경우
        if fanState == "on" then
            fanState = "off"
        elseif fanState == "off" then
            fanState = "pressed"
        elseif fanState == "pressed" then
            -- 코드를 뽑는 기능 추가
            print("코드를 뽑았습니다.")
            fanState = "on"
        end
    end
end
