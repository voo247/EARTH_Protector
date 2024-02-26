local faucetImages = {
    "수도꼭지1.png",
    "수도꼭지2.png",
    "수도꼭지3.png",
    "수도꼭지4.png"
}

local currentImageIndex = 1
local tapCount = 0

--배경
local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
    background.strokeWidth = 10
    background:setStrokeColor( 0.6 )
    background:setFillColor(1, 1, 0.9 )

    local title = display.newText("핸들을 클릭해 물을 멈춰주세요!", display.contentWidth/2, display.contentHeight*0.2)
    title:setFillColor( 0 )
    title.size = 70

-- 이미지 로드 함수
local function loadImages()
    -- 이미지 로드 코드
    print("이미지를 로드했습니다.")
end

-- 이미지 로드
loadImages()

-- 이미지를 표시하는 함수
local function drawImage()
    print("현재 이미지: " .. faucetImages[currentImageIndex])
end

-- 초기 이미지 표시
drawImage()

-- 사용자의 입력(탭)을 받아서 처리하는 함수
local function processInput()
    tapCount = (tapCount + 1) % 6  -- 0부터 5까지 순환
    
    if tapCount == 0 or tapCount == 2 then
        currentImageIndex = 1
    elseif tapCount == 1 or tapCount == 3 then
        currentImageIndex = 2
    elseif tapCount == 4 then
        currentImageIndex = 3
    elseif tapCount == 5 then
        currentImageIndex = 4
    end
    
    drawImage()  -- 이미지 표시
end

-- 사용자 입력 처리
while true do
    print("핸들을 클릭해주세요.")
    io.read()  -- 사용자 입력 대기
    processInput()  -- 입력 처리
end

