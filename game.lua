-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	physics.start()
	physics.setDrawMode("hybrid")
	

	--- 배경 추가------------
	local background = display.newImageRect("image/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--- 캐릭터 추가 ---------
	local player = display.newImage("image/캐릭터_옆면3.png")
	player.x, player.y = display.contentWidth*0.16, display.contentHeight*0.3
	player.name = "player"

	--- 캐릭터 움직이기 ---------

	local function onKeyEvent(event)
		local playerX, playerY = player.x, player.y

	    if event.phase == "down" then
	        if event.keyName == "right" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/캐릭터_옆면3.png")
	            player.x, player.y = playerX + 100, playerY
	        elseif event.keyName == "left" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/캐릭터_옆면2.png")
	            player.x, player.y = playerX - 100, playerY
	        elseif event.keyName == "up" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/캐릭터_뒷면1.png")
	            player.x, player.y = playerX, playerY - 100
	        elseif event.keyName == "down" then
	            playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/캐릭터_정면.png")
	            player.x, player.y = playerX, playerY + 100
	        end
	    end
	end

	Runtime:addEventListener("key", onKeyEvent)




	--- 점수 추가 -----------
	local score = display.newText(0, display.contentWidth*0.62, display.contentHeight*0.1)
	score.size = 100

	score:setFillColor(0)



    --- 수락이미지 ----------------
   local accept = display.newImage("image/수락_이미지.png")
	accept.x, accept.y = display.contentWidth*0.8, display.contentHeight*0.3
    accept.height = 100
    accept.width = 100
    
   


   ------ 스페셜 퀘스트 1번 --------------------------------------
local function moveAlien(alien)
    local destX = math.random(display.contentWidth)
    local destY = math.random(display.contentHeight)
    
    transition.to(alien, {time = 1000, x = destX, y = destY, onComplete = function()
        moveAlien(alien)
    end})
end

-- 외계인 생성 및 터치 이벤트 처리
local function createAlien()
    local alien = display.newImage("image/외계인.png")
    alien.height = 200
    alien.width = 200
    alien.x, alien.y = math.random(display.contentWidth), math.random(display.contentHeight)
    
    -- 외계인 터치 이벤트 처리
    local function onTouch(event)
        if event.phase == "began" then
            display.remove(alien)
        end
        return true
    end

    alien:addEventListener("touch", onTouch)
    
    moveAlien(alien)
    return alien
end

-- 외계인 여러 개 생성
local function createAliens(numAliens)
    for i = 1, numAliens do
        createAlien()
    end
end

local function onAcceptTouch(event)
    if event.phase == "ended" then
        display.remove(accept)

        display.remove(player)
        player = display.newImage("image/총든_플레이어.png")
        player.x, player.y = display.contentWidth * 0.16, display.contentHeight * 0.3

        createAliens(4)
    end
    return true
end

accept:addEventListener("touch", onAcceptTouch)

----------------------------------끝
end


function scene:show( event )
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
end

function scene:destroy( event )
	local sceneGroup = self.view
	
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
