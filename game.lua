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
	local background = display.newImageRect("image/배경_인물/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--- 캐릭터 추가 ---------
	local player = display.newImage("image/배경_인물/캐릭터_옆면3.png")
	player.x, player.y = display.contentWidth*0.16, display.contentHeight*0.3
	player.name = "player"

	--- 캐릭터 움직이기 ---------

	local function onKeyEvent(event)
		local playerX, playerY = player.x, player.y

	    if event.phase == "down" then
	        if event.keyName == "right" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/배경_인물/캐릭터_옆면3.png")
	            player.x, player.y = playerX + 100, playerY
	        elseif event.keyName == "left" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/배경_인물/캐릭터_옆면2.png")
	            player.x, player.y = playerX - 100, playerY
	        elseif event.keyName == "up" then
	        	playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/배경_인물/캐릭터_뒷면1.png")
	            player.x, player.y = playerX, playerY - 100
	        elseif event.keyName == "down" then
	            playerX, playerY = player.x, player.y
	        	display.remove(player)
	        	player = display.newImage("image/배경_인물/캐릭터_정면.png")
	            player.x, player.y = playerX, playerY + 100
	        end
	    end
	end

	Runtime:addEventListener("key", onKeyEvent)

	--- 점수 추가 -----------
	score = display.newText(0, display.contentWidth*0.625, display.contentHeight*0.095)
 	score.size = 70
 	score:setFillColor(255, 255, 255)

	--- 타이머 추가 -----------
	local time= display.newText(75, display.contentWidth*0.37, display.contentHeight*0.1)
 	time.size = 100
 	time:setFillColor(0)


	-- 퀘스트 진행 중 기존 게임화면에 비의도적 변동사항이 없도록 키보드 입력 중단/재개하는 코드 --
	local function questStart()
		Runtime:removeEventListener("key", onKeyEvent)
	end
	local function questEnd(event)
		if not Runtime:hasEventListener("key", onKeyEvent) then
			Runtime:addEventListener("key", onKeyEvent)
		end
	end

	Runtime:addEventListener("questEnd", questEnd)

	--[[ @@ 용법
	1. 퀘스트 관련 코딩을 lua로 하신다면
	해당 씬을 끝낼 때 'scene:destroy()' 코드를 추가해주세요(create에 추가)
	
	destroy에는 
	local event = { name = "questEnd" }
	Runtime:dispatchEvent(event)
	를 추가해주세요

	2. game.lua에 바로 코드를 입력하시는 경우
	questStart(), questEnd() 함수 직접 호출해주시면 사용가능합니다.
	]]

	-- 퀘스트 성공 여부 --
	local success = {
		q1 = "F",
		q2 = "F",
		q3 = "F",
		q4 = "F",
		q5 = "F",
		q6 = "F",
		q7 = "F",
		specialQ1 = "F",
		specialQ2 = "F"
	}


	------ 스페셜 퀘스트 1번 : 외계인 침공 --------------------------------------
	local aliensCreated = 0 -- 생성된 외계인의 수
	local alien_score = 0 -- 외계인 사냥 점수
	local alien_timer -- 외계인 퀘스트 타이머 
	local alien_timeAttack
	local aliens = {} -- 외계인 테이블

	--- 총 이미지 (수락) -------
   local accept = display.newImage("image/자료2/총.png")
	accept.x, accept.y = display.contentWidth*0.85, display.contentHeight*0.8
    accept.height = 170
    accept.width = 170

	local function moveAlien(alien)
	    local destX = math.random(display.contentWidth)
	    local destY = math.random(display.contentHeight)
	    
	    transition.to(alien, {time = 1000, x = destX, y = destY, onComplete = function()
	        moveAlien(alien)
	    end})
	end

	-- 외계인 생성 및 터치 이벤트 처리
	local function createAlien()
	    local alien = display.newImage("image/배경_인물/외계인.png")
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

	-- 타이머 카운트 함수(게임 종료)
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
	    if distance <= 100 and aliensCreated < 10 then

	        for i = 1, 10 do
	            createAlien() -- 외계인 10마리 생성
	            aliensCreated = 10 -- 생성된 외계인의 수를 10으로 설정하여 더 이상 생성되지 않도록 함
	        end

	        alien_timer = display.newText(15, display.contentWidth*0.43, display.contentHeight*0.105)
		 	alien_timer.size = 85
		 	alien_timer:setFillColor(1, 0, 0)
		 	alien_timer.alpha = 0.8

		 	alien_timeAttack = timer.performWithDelay(1000, alien_counter, 16)


	        -- 캐릭터 이미지를 캐릭터_총 이미지로 변경
	        display.remove(player)
	        player = display.newImage("image/자료2/캐릭터_총.png")
	        player.x, player.y = display.contentWidth*0.85, display.contentHeight*0.8
	    end
	end




	local function onEnterFrame(event)
	    createAliensNearPlayer()
	end

	Runtime:addEventListener("enterFrame", onEnterFrame)

	------ 외계인 침공 끝 --------------------------------------



	----- 일반 퀘스트 1번 실행 : 전기 스위치 끄기 ------------
	local quest1Icon = display.newImage("image/배경_인물/퀘스트박스.png")
	quest1Icon.x, quest1Icon.y = display.contentWidth*0.85, display.contentHeight*0.55
    quest1Icon.height, quest1Icon.width = 150, 150

    local quest1Alarm = display.newImage("image/퀘스트알람/퀘스트_스위치.png")
	quest1Alarm.x, quest1Alarm.y = display.contentWidth * 0.8, display.contentHeight * 0.45


	local function checkQuest1(quest1Icon)
		if (player.x > quest1Icon.x - 100 and player.x < quest1Icon.x + 100
			and player.y > quest1Icon.y - 100 and player.y < quest1Icon.y + 100) then

			questStart()
			composer.showOverlay("light_off_game")
			display.remove(quest1Icon)
			display.remove(quest1Alarm)
			success.q1 = "T"
		end
	end


	-- 일반 퀘스트 2번 실행 : 분리수거(드래그) --
	local quest2Icon = display.newImage("image/배경_인물/퀘스트박스.png")
	quest2Icon.x, quest2Icon.y = display.contentWidth*0.29, display.contentHeight*0.325 -- @@위치 수정 요
    quest2Icon.height, quest2Icon.width = 150, 150

    local quest2Alarm = display.newImage("image/퀘스트알람/퀘스트_쓰레기.png")
	quest2Alarm.x, quest2Alarm.y = display.contentWidth * 0.25, display.contentHeight * 0.2


	local function checkQuest2(quest2Icon)
		if (player.x > quest2Icon.x - 100 and player.x < quest2Icon.x + 100
			and player.y > quest2Icon.y - 100 and player.y < quest2Icon.y + 100) then

			questStart()
			composer.showOverlay("questRecycle")
			display.remove(quest2Icon)
			display.remove(quest2Alarm)
			success.q2 = "T"
		end
	end



	-- 일반 퀘스트 3번 실행 : 에어컨 온도 맞추기 -----
	local quest3Icon = display.newImage("image/배경_인물/퀘스트박스.png")
	quest3Icon.x, quest3Icon.y = 300, 860
	quest3Icon.height, quest3Icon.width = 150, 150

	local quest3Alarm = display.newImage("image/퀘스트알람/퀘스트_에어컨.png")
	quest3Alarm.x, quest3Alarm.y = display.contentWidth * 0.1, display.contentHeight * 0.68

	local function checkQuest3(quest3Icon)
		if (player.x > quest3Icon.x - 100 and player.x < quest3Icon.x + 100
			and player.y > quest3Icon.y - 100 and player.y < quest3Icon.y + 100) then

			questStart()
			composer.showOverlay("questTemp")
			display.remove(quest3Icon)
			display.remove(quest3Alarm)
			success.q3 = "T"
		end
	end

	
	-- 일반 퀘스트 6번 : 걷기 --
	local quest6Icon = display.newImage("image/배경_인물/퀘스트박스.png")
	quest6Icon.x, quest6Icon.y = display.contentWidth*0.568, display.contentHeight*0.325
	quest6Icon.height, quest6Icon.width = 150, 150

	local quest6Alarm = display.newImage("image/퀘스트알람/퀘스트_걷기.png")
	quest6Alarm.x, quest6Alarm.y = display.contentWidth * 0.528, display.contentHeight * 0.2

	local function sendPlayerPosition()
		local playerPositionEvent = {
			name = "playerPositionUpdate",
			x = player.x,
			y = player.y
		}
		Runtime:dispatchEvent(playerPositionEvent)
	end

	Runtime:addEventListener("key", sendPlayerPosition)

	local responeX, respawnY
	local function checkQuest6(quest6Icon)
		if (player.x > quest6Icon.x - 40 and player.x < quest6Icon.x + 40
			and player.y > quest6Icon.y - 40 and player.y < quest6Icon.y + 40) then
			--questStart()
			composer.showOverlay("questWalk")
			respawnX, respawnY = quest6Icon.x, quest6Icon.y - 80
			display.remove(quest6Icon)
			display.remove(quest6Alarm)
			success.q6 = "T"
		end
	end




		----- 일반 퀘스트 7번 실행 : 나무심기 ------------
	local quest7Icon = display.newImage("image/배경_인물/퀘스트박스.png")
	quest7Icon.x, quest7Icon.y = display.contentWidth*0.85, display.contentHeight*0.55
    quest7Icon.height, quest7Icon.width = 150, 150

    local quest7Alarm = display.newImage("image/퀘스트알람/퀘스트_스위치.png")
	quest7Alarm.x, quest7Alarm.y = display.contentWidth * 0.8, display.contentHeight * 0.45


	local function checkQuest7(quest7Icon)
		if (player.x > quest7Icon.x - 100 and player.x < quest7Icon.x + 100
			and player.y > quest7Icon.y - 100 and player.y < quest7Icon.y + 100) then

			questStart()
			composer.showOverlay("quest_tree")
			display.remove(quest7Icon)
			display.remove(quest7Alarm)
			success.q7 = "T"
		end
	end


	

	local function resetPosition(event)
	        if event.name == "restart" then
	            player.x = respawnX
				player.y = respawnY
	        end
	end
	    
	Runtime:addEventListener("restart", resetPosition)
	
	

	-- 퀘스트 반경 확인 --

	local function onEnterFrame(event)
  --   		if success.specialQ1 == "F" then
		-- 	checkQuest(quest1)
		-- end
		if success.q1 == "F" then
			checkQuest1(quest1Icon)
		end
		if success.q2 == "F" then
			checkQuest2(quest2Icon)
		end
		if success.q3 == "F" then
			checkQuest3(quest3Icon)
		end
		if success.q6 == "F" then
			checkQuest6(quest6Icon)
		end
		if success.q7 == "F" then
			checkQuest7(quest7Icon)
		end
	end

	Runtime:addEventListener("enterFrame", onEnterFrame)
	


 	sceneGroup:insert(background)
 	sceneGroup:insert(player)
 	sceneGroup:insert(score)
 	sceneGroup:insert(time)
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
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end]]

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
