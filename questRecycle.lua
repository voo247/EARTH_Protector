-- 일반 퀘스트 2번 실행 : 분리수거(드래그) --

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	physics.start()
	physics.setDrawMode("hybrid")

    -- 바탕 --
    local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
 	background.strokeWidth = 10
	background:setStrokeColor( 0.6 )
 	background:setFillColor(1, 1, 0.9 )

 	local title = display.newText("분리수거", display.contentWidth/2, display.contentHeight*0.2)
 	title:setFillColor( 0.6 )
 	title.size = 70

    -- 쓰레기통과 쓰레기가 겹치는가? --
    local function isOverlap(trashBucket, trash)
        if (trash.x + trash.width / 2 > trashBucket.x - trashBucket.width / 2
        and trash.x - trash.width / 2 < trashBucket.x + trashBucket.width / 2
        and trash.y + trash.height / 2 > trashBucket.y - trashBucket.height / 2
        and trash.y - trash.height / 2 < trashBucket.y + trashBucket.height / 2) then
            return true
        else
            return false
        end
    end

    -- 쓰레기통 구현 --
    local trashCan = display.newImage("image/쓰레기통_can.png")
    trashCan.x, trashCan.y = display.contentWidth * 0.2475, display.contentHeight * 0.52
    trashCan.height, trashCan.width = trashCan.height * 2., trashCan.width * 2
    local trashGlass = display.newImage("image/쓰레기통_glass.png")
    trashGlass.x, trashGlass.y = display.contentWidth * 0.4125, display.contentHeight * 0.52
    trashGlass.height, trashGlass.width = trashGlass.height * 2, trashGlass.width * 2
    local trashPlastic = display.newImage("image/쓰레기통_plastic.png")
    trashPlastic.x, trashPlastic.y = display.contentWidth * 0.5775, display.contentHeight * 0.52
    trashPlastic.height, trashPlastic.width = trashPlastic.height * 2, trashPlastic.width * 2
    local trashWaste = display.newImage("image/쓰레기통_waste.png")
    trashWaste.x, trashWaste.y = display.contentWidth * 0.7425, display.contentHeight * 0.52
    trashWaste.height, trashWaste.width = trashWaste.height * 2, trashWaste.width * 2
    
    -- 쓰레기 랜덤 배치 --
    local imagePaths = {
        "image/쓰레기1.png",
        "image/쓰레기2.png",
        "image/쓰레기3.png",
        "image/쓰레기4.png",
        "image/쓰레기5.png",
        "image/쓰레기6.png",
        "image/쓰레기7.png"
    }
    
    local trashGroup = display.newGroup()
    local trash = {}

    math.randomseed(os.time())
    local function randomXYPosition()
        local x = math.random(display.contentWidth * 0.1, display.contentWidth * 0.9)
        local y = math.random(display.contentHeight * 0.2, display.contentHeight * 0.8)

        return x, y
    end
    
    for i = 1, 7 do
        local trashImage = display.newImage(imagePaths[i])
        trashImage.width, trashImage.height = trashImage.width * 2, trashImage.height * 2

        local x, y = randomXYPosition()
        trashImage.x, trashImage.y = x, y

        while (isOverlap(trashCan, trashImage) or isOverlap(trashGlass, trashImage) or isOverlap(trashPlastic, trashImage) or isOverlap(trashWaste, trashImage)) do
            x, y = randomXYPosition()
            trashImage.x, trashImage.y = x, y
        end

        trash[i] = trashImage
    end

    -- 쓰레기 맞는 쓰레기통에 드래그 하면 플레이어에게 보이지 않도록 설정 --
    local visibleTrash = 7
    local function dragTrash( event )
        if( event.phase == "began" ) then
            display.getCurrentStage():setFocus( event.target )
            event.target.isFocus = true
        elseif( event.phase == "moved" ) then
            if ( event.target.isFocus ) then
                event.target.x = event.xStart + event.xDelta
                event.target.y = event.yStart + event.yDelta
            end
        elseif ( event.phase == "ended" or event.phase == "cancelled") then
            if ( event.target.isFocus ) then
                display.getCurrentStage():setFocus( nil )
                event.target.isFocus = false
                if(event.target == trash[1] and isOverlap(trashWaste, trash[1])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[2] and isOverlap(trashGlass, trash[2])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[3] and isOverlap(trashPlastic, trash[3])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[4] and isOverlap(trashWaste, trash[4])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[5] and isOverlap(trashGlass, trash[5])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[6] and isOverlap(trashPlastic, trash[6])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                elseif (event.target == trash[7] and isOverlap(trashWaste, trash[7])) then
                    event.target.isVisible = false
                    visibleTrash = visibleTrash - 1
                end
            else
                display.getCurrentStage():setFocus( nil )
                event.target.isFocus = false
            end
        end
    end

    for i = 1, 7 do
        trash[i]:addEventListener("touch", dragTrash)
    end

    -- 미니게임 종료 --
    local function questEnd(event)
        if (visibleTrash == 0) then
            display.remove(background)
            display.remove(title)
            display.remove(trashCan)
            display.remove(trashGlass)
            display.remove(trashPlastic)
            display.remove(trashWaste)
            for i = 1, 7 do
                display.remove(trash[i])
            end

            scene:destroy()
            composer.removeScene("questRecycle")
            composer.gotoScene("game")
        end
    end

    Runtime:addEventListener("enterFrame", questEnd)
end

--[[function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end]]

function scene:destroy( event )
	local sceneGroup = self.view
	
    local event = { name = "questEnd" }
    Runtime:dispatchEvent(event)

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene