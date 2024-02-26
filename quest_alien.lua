-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local score

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
	score = display.newText(0, display.contentWidth*0.62, display.contentHeight*0.1, "source/나눔손글씨 신혼부부.ttf")
	score.size = 100

	score:setFillColor(0)



    --- 총 이미지 (수락) ----------------
   local accept = display.newImage("image/총.png")
	accept.x, accept.y = display.contentWidth*0.8, display.contentHeight*0.8
    accept.height = 180
    accept.width = 180
   


	  ------ 스페셜 퀘스트 1번 --------------------------------------
	local aliensCreated = 0 -- 생성된 외계인의 수
	local alien_score = 0 -- 외계인 사냥 점수
	local alien_timer -- 외계인 퀘스트 타이머 
	local alien_timeAttack
	local aliens = {} -- 외계인 테이블


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
	            alien_score = alien_score + 3
	        end
	        return true
	    end

	    alien:addEventListener("touch", onTouch)
	    
	    moveAlien(alien)
	    table.insert(aliens, alien)
	    return alien
	end

	-- 타이머 카운트 함수
	local function alien_counter( event )
		alien_timer.text = alien_timer.text - 1

		if(alien_score == 30) then
			score.text = score.text + 40
			alien_score = 0
			alien_timer.alpha = 0
			accept.x = 3000
		elseif(alien_timer.text == '-1' and alien_score < 30) then
			for i = 0, (30 - alien_score)/3 do
				local removedAlien = table.remove(aliens)  -- 테이블에서 외계인 제거
                display.remove(removedAlien)
	        end
	        score.text = score.text - 40
			alien_score = 0
			alien_timer.alpha = 0
			accept.x = 3000
		end
	end

	local function createAliensNearPlayer()
	    -- 캐릭터와 총 이미지의 중심 위치 계산
	    local playerCenterX, playerCenterY = player.x + player.width / 2, player.y + player.height / 2
	    local acceptCenterX, acceptCenterY = accept.x + accept.width / 2, accept.y + accept.height / 2

	    -- 캐릭터와 총 이미지 사이의 거리 계산
	    local distance = math.sqrt((playerCenterX - acceptCenterX)^2 + (playerCenterY - acceptCenterY)^2)

	    -- 플레이어와 총 이미지 사이의 거리가 일정 값 이하이고 외계인이 아직 생성되지 않은 경우에만 외계인 생성
	    if distance <= 200 and aliensCreated < 10 then

	        for i = 1, 10 do
	            createAlien() -- 외계인 10마리 생성
	            aliensCreated = 10 -- 생성된 외계인의 수를 10으로 설정하여 더 이상 생성되지 않도록 함
	        end

	        alien_timer = display.newText(15, display.contentWidth*0.355, display.contentHeight*0.1, "source/나눔손글씨 신혼부부.ttf")
		 	alien_timer.size = 80
		 	alien_timer:setFillColor(1, 0, 0)
		 	alien_timer.alpha = 0.8

		 	alien_timeAttack = timer.performWithDelay(1000, alien_counter, 16)


	        -- 캐릭터 이미지를 캐릭터_총 이미지로 변경
	        display.remove(player)
	        player = display.newImage("image/캐릭터_총.png")
	        player.x, player.y = display.contentWidth*0.8, display.contentHeight*0.6
	    end
	end




	local function onEnterFrame(event)
	    createAliensNearPlayer()
	end

	Runtime:addEventListener("enterFrame", onEnterFrame)


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

