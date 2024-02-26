local fanImage1 = "image/선풍기/선풍기1.png"
local fanImage2 = "image/선풍기/선풍기2.png"
local fanImage3 = "image/선풍기/선풍기3.png"
local fanImage4 = "image/선풍기/선풍기4.png"
local fanState = 0  -- 선풍기 클릭 횟수


--배경
local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
    background.strokeWidth = 10
    background:setStrokeColor( 0.6 )
    background:setFillColor(1, 1, 0.9 )

    local title = display.newText("선풍기를 꺼주세요!", display.contentWidth/2, display.contentHeight*0.2)
    title:setFillColor( 0 )
    title.size = 70


-- 빈 화면을 출력하는 함수
local function clearScreen()
    for i = 1, 25 do
        print()
    end
end

-- 선풍기 이미지를 출력하는 함수
local function drawFan(image)
    clearScreen()
    print(image)
end

-- 초기화
drawFan(fanImage1)

-- 탭 횟수에 따라 선풍기 이미지 변경
local tapCount = 0  -- 탭 횟수 초기화
while true do
    print("탭을 입력하세요 (엔터 키를 누르십시오): ")
    io.read()  -- 엔터 키 입력 대기

    tapCount = tapCount + 1  -- 탭 횟수 증가
    -- 탭 횟수에 따라 이미지 변경
    if tapCount == 1 then
        fanState = 0
        drawFan(fanImage1)
    elseif tapCount == 2 then
        fanState = 1
        drawFan(fanImage2)
    elseif tapCount == 3 then
        fanState = 0
        drawFan(fanImage1)
    elseif tapCount == 4 then
        fanState = 2
        drawFan(fanImage3)
    elseif tapCount == 5 then
        fanState = 3
        drawFan(fanImage4)
        tapCount = 0  -- 탭 횟수 초기화
    end
end
