-- 일반 퀘스트 7번 실행 : 나무 심기 --

local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")

function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setDrawMode("hybrid")

    -- 배경 추가
    local background = display.newImageRect("image/배경_인물/배경.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth / 2, display.contentHeight / 2

    local title = display.newText("나무를 심자!", display.contentWidth/2, display.contentHeight*0.2, "source/나눔손글씨 신혼부부.ttf")
    title:setFillColor( 0.6 )
    title.size = 70

    -- 점수 추가
    local score = display.newText(0, display.contentWidth * 0.62, display.contentHeight * 0.1, native.systemFont, 100, "source/나눔손글씨 신혼부부.ttf")
    score:setFillColor(0)

    -- 바구니 이미지
    local basket = display.newImage("image/나무/씨앗.png")
    basket.x, basket.y = display.contentWidth * 0.2, display.contentHeight * 0.8
    basket.height = 300
    basket.width = 300

    -- 물뿌리개 이미지
    local water = display.newImage("image/나무/물뿌리개.png")
    water.x, water.y = display.contentWidth * 0.75, display.contentHeight * 0.79
    water.height = 350
    water.width = 500

    -- 나무 이미지를 중앙에 배치
    local tree = display.newImage("image/나무/t1.png")
    tree.x = display.contentCenterX
    tree.y = display.contentCenterY



    ----------바구니 클릭하면 씨앗없는 바구니로-----
    local function onBasketClick(event)
    if event.phase == "ended" then
        if basket then
            basket:removeSelf()  -- 이전에 생성된 씨앗 이미지 제거
        end
        -- 새로운 씨앗 이미지 생성
        basket = display.newImage("image/나무/씨앗_사용후png.png")
        basket.x, basket.y = display.contentWidth * 0.2, display.contentHeight * 0.8
        basket.height = 300
        basket.width = 300
    end
end

-- 씨앗 이미지에 클릭 이벤트 리스너 추가
basket:addEventListener("touch", onBasketClick)

    ----------이미지1이 이미지2로--------------
    local waterClickCount = 0

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 3 then
            -- 나무 이미지를 이미지 2로 대체
                --tree:removeSelf()  -- 기존 나무 이미지 제거
                display.remove(tree)
                local tree2 = display.newImage("image/나무/t2.png")  -- 새로운 나무 이미지 생성
                tree2.x = display.contentCenterX
                tree2.y = display.contentCenterY

                transition.to(tree2, {time = 4000, alpha = 0})
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)





    ------이미지2가 이미지3로----------------------------  
    local waterClickCount = 0

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 6 then
            -- 나무 이미지를 이미지 3로 대체
                --tree:removeSelf()  -- 기존 나무 이미지 제거
                display.remove(tree)
                local tree3 = display.newImage("image/나무/t3.png")  -- 새로운 나무 이미지 생성
                tree3.x = display.contentCenterX
                tree3.y = display.contentCenterY

                transition.to(tree3, {time = 4000, alpha = 0})
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)




  ------이미지3이 이미지4로----------------------------  
    local waterClickCount = 0

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 9 then
            -- 나무 이미지를 이미지 4로 대체
                --tree:removeSelf()  -- 기존 나무 이미지 제거
                display.remove(tree)
                local tree4 = display.newImage("image/나무/t4.png")  -- 새로운 나무 이미지 생성
                tree4.x = display.contentCenterX
                tree4.y = display.contentCenterY

                transition.to(tree4, {time = 4000, alpha = 0})
            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)


  ------이미지4가 이미지5로----------------------------  
    local waterClickCount = 0

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 12 then
            -- 나무 이미지를 이미지 5로 대체
                --tree:removeSelf()  -- 기존 나무 이미지 제거
                display.remove(tree)
                local tree5 = display.newImage("image/나무/t5.png")  -- 새로운 나무 이미지 생성
                tree5.x = display.contentCenterX
                tree5.y = display.contentCenterY

                --서서히 사라지게
                transition.to(tree5, {time = 3500, alpha = 0})
                



            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)



--------------------모든 나무 이미지가 5번째 이미지가 되면 점수 +15--------------
-- 점수 변수
local tree_score = 0 -- 나무 점수

local waterClickCount = 0

-- 물뿌리개 이미지 클릭 이벤트 처리
local function onWaterClick(event)
    if event.phase == "ended" then
        waterClickCount = waterClickCount + 1
        if waterClickCount == 12 then
            score.text = score.text + 20


            -- 클릭 횟수 초기화
            waterClickCount = 0
        end
    end
    return true  -- 이벤트 전파 중단
end

-- 물뿌리개 이미지에 클릭 이벤트 리스너 추가
water:addEventListener("touch", onWaterClick)




--end
---------------------------------------------------------------------------------


    -- 일퀘7번 종료 --
    local function questEnd(event)
        if tonumber(score.text) == 20 then
            display.remove(background)
            display.remove(title)
            display.remove(water)
            display.remove(basket)
            display.remove(tree)
            --end

            scene:destroy()
            composer.removeScene("quest_tree")
            composer.gotoScene("game")
        end
    end

    Runtime:addEventListener("enterFrame", questEnd)

end

    
---------------------------------------------------------------------------------
function scene:destroy( event )
    local sceneGroup = self.view
    
    local event = { name = "questEnd" }
    Runtime:dispatchEvent(event)
end


-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
