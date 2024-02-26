local faucetImages = {
    "image/수도꼭지/수도꼭지1.png",
    "image/수도꼭지/수도꼭지2.png",
    "image/수도꼭지/수도꼭지3.png",
    "image/수도꼭지/수도꼭지4.png"
}

local currentImageIndex = 1
local tapCount = 0

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

-- 핸들 클릭 이벤트 처리
local function handleTapEvent(event)
    processInput()  -- 입력 처리
end

-- 핸들에 대한 탭 이벤트 리스너 등록
Runtime:addEventListener("tap", handleTapEvent)

