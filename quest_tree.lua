-- 일반 퀘스트 7번 실행 : 나무 심기 --

local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")

function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setDrawMode("hybrid")

    -- 배경 추가
    local background = display.newImageRect("image/배경.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight / 2

    -- 점수 추가
    local score = display.newText(0, display.contentWidth * 0.62, display.contentHeight * 0.1, native.systemFont, 100)
    score:setFillColor(0)

    -- 캐릭터 추가
    --local player = display.newImage("image/캐릭터_정면.png")
    --player.x, player.y = display.contentWidth * 0.5, display.contentHeight * 0.8
    --player.name = "player"

    -- 바구니 이미지
    local basket = display.newImage("image/씨앗.png")
    basket.x, basket.y = display.contentWidth * 0.2, display.contentHeight * 0.8
    basket.height = 300
    basket.width = 300

    -- 물뿌리개 이미지
    local water = display.newImage("image/물뿌리개.png")
    water.x, water.y = display.contentWidth * 0.75, display.contentHeight * 0.79
    water.height = 350
    water.width = 500

    -- 나무 이미지
    -- 나무 이미지를 중앙에 2행 3열로 배치
local numRows = 2
local numCols = 3
local treeWidth = 200
local treeHeight = 200
local treeSpacingX = 300 -- 나무 이미지 간의 가로 간격
local treeSpacingY = 200 -- 나무 이미지 간의 세로 간격

for row = 1, numRows do
    for col = 1, numCols do
        local tree = display.newImage("image/1.png")
        tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
        tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
        tree.width = treeWidth
        tree.height = treeHeight
    end
end
    

    ----------바구니 클릭하면 씨앗없는 바구니로-----
    local function onBasketClick(event)
    if event.phase == "ended" then
        if basket then
            basket:removeSelf()  -- 이전에 생성된 씨앗 이미지 제거
        end
        -- 새로운 씨앗 이미지 생성
        basket = display.newImage("image/씨앗_사용후png.png")
        basket.x, basket.y = display.contentWidth * 0.2, display.contentHeight * 0.8
        basket.height = 300
        basket.width = 300
    end
end

-- 씨앗 이미지에 클릭 이벤트 리스너 추가
basket:addEventListener("touch", onBasketClick)

    ----------이미지1이 이미지2로--------------
    local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 2 then
            -- 모든 나무 이미지를 이미지 2로 대체
            for i = 1, treeGroup.numChildren do
                local tree = treeGroup[i]
                tree:removeSelf()  -- 기존 나무 이미지 제거
                local newTree = display.newImage(tree3Image)  -- 새로운 나무 이미지 생성
                newTree.x, newTree.y = tree.x, tree.y
                newTree.width, newTree.height = tree.width, tree.height
                treeGroup:insert(newTree)  -- 새로운 나무 이미지를 그룹에 추가
            end
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()




    ------이미지2가 이미지3로----------------------------  
    local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 4 then
            -- 모든 나무 이미지를 이미지 3으로 대체
            for i = 1, treeGroup.numChildren do
                local tree = treeGroup[i]
                tree:removeSelf()  -- 기존 나무 이미지 제거
                local newTree = display.newImage(tree3Image)  -- 새로운 나무 이미지 생성
                newTree.x, newTree.y = tree.x, tree.y
                newTree.width, newTree.height = tree.width, tree.height
                treeGroup:insert(newTree)  -- 새로운 나무 이미지를 그룹에 추가
            end
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()
  

  ------이미지3가 이미지4로----------------------------  
    local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 6 then
            -- 모든 나무 이미지를 이미지 4로 대체
            for i = 1, treeGroup.numChildren do
                local tree = treeGroup[i]
                tree:removeSelf()  -- 기존 나무 이미지 제거
                local newTree = display.newImage(tree4Image)  -- 새로운 나무 이미지 생성
                newTree.x, newTree.y = tree.x, tree.y
                newTree.width, newTree.height = tree.width, tree.height
                treeGroup:insert(newTree)  -- 새로운 나무 이미지를 그룹에 추가
            end
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()

  ------이미지4가 이미지5로----------------------------  
    local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 8 then
            -- 모든 나무 이미지를 이미지 5로 대체
            for i = 1, treeGroup.numChildren do
                local tree = treeGroup[i]
                tree:removeSelf()  -- 기존 나무 이미지 제거
                local newTree = display.newImage(tree5Image)  -- 새로운 나무 이미지 생성
                newTree.x, newTree.y = tree.x, tree.y
                newTree.width, newTree.height = tree.width, tree.height
                treeGroup:insert(newTree)  -- 새로운 나무 이미지를 그룹에 추가
            end
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()

------이미지4가 이미지5로----------------------------  
    local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 10 then
            -- 모든 나무 이미지를 이미지 5로 대체
            for i = 1, treeGroup.numChildren do
                local tree = treeGroup[i]
                tree:removeSelf()  -- 기존 나무 이미지 제거
                local newTree = display.newImage(tree5Image)  -- 새로운 나무 이미지 생성
                newTree.x, newTree.y = tree.x, tree.y
                newTree.width, newTree.height = tree.width, tree.height
                treeGroup:insert(newTree)  -- 새로운 나무 이미지를 그룹에 추가
            end
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()



--------------------모든 나무 이미지가 5번쨰 이미지가 되면 점수 +15--------------
-- 점수 변수
local tree_score = 0 -- 나무 점수

local waterClickCount = 0
local tree1Image = "image/1.png"
local tree2Image = "image/2.png"
local tree3Image = "image/3.png"
local tree4Image = "image/4.png"
local tree5Image = "image/5.png"

-- 나무 이미지 그룹
local treeGroup = display.newGroup()

-- 나무 이미지를 그리는 함수
local function drawTrees()
    for row = 1, numRows do
        for col = 1, numCols do
            local tree = display.newImage(tree1Image)
            tree.x = (display.contentWidth - (numCols - 1) * treeSpacingX) / 2 + (col - 1) * treeSpacingX
            tree.y = (display.contentHeight - (numRows - 1) * treeSpacingY) / 2 + (row - 1) * treeSpacingY
            tree.width = treeWidth
            tree.height = treeHeight
            treeGroup:insert(tree)
        end
    end
end

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 24 then
        	score.text = score.text + 15
            
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)

-- 나무 이미지 그리기
drawTrees()

















end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
