-----------------------------------------------------------------------------------------
--
-- game.lua
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
	local score = display.newText(0, display.contentWidth*0.625, display.contentHeight*0.095)
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

	
	--- 외계인 퀘스트 -------
	local quest1 = display.newImage("image/총.png")
	quest1.height = 150
	quest1.width = 150
	quest1.x, quest1.y = 300, 860

	local function checkQuest(quest)
		if (player.x > quest.x - 100 and player.x < quest.x + 100
			and player.y > quest.y - 100 and player.y < quest.y + 100) then

			composer.showOverlay("quest_alien")
			display.remove(quest)
			success.specialQ1 = "T"
		end
	end

	-- 일반 퀘스트 2번 실행 : 분리수거(드래그) --
	local quest2Icon = display.newImage("image/퀘스트박스.png")
	quest2Icon.x, quest2Icon.y = display.contentWidth*0.29, display.contentHeight*0.325 -- @@위치 수정 요
    quest2Icon.height, quest2Icon.width = 150, 150

	local function checkQuest2(quest2Icon)
		if (player.x > quest2Icon.x - 100 and player.x < quest2Icon.x + 100
			and player.y > quest2Icon.y - 100 and player.y < quest2Icon.y + 100) then

			questStart()
			composer.showOverlay("questRecycle")
			display.remove(quest2Icon)
			success.q2 = "T"
		end
	end

	-----일반 퀘스트(전기 스위치 끄기 퀘스트)------------
	local light = display.newImage("image/퀘스트박스.png")
	light.x, light.y = display.contentWidth*0.85, display.contentHeight*0.55
	light.height, light.width = 150,150
	local function lightQuest(event)
		if event.phase == "ended" then
			display.remove(light)
			questStart()
			composer.gotoScene("light_off_game")
		end
	end
	light:addEventListener("touch", lightQuest)


	

	--- 에어컨 온도 맞추기 -----
	-- local quest2 = display.newImage("image/퀘스트박스.png")
	-- quest2.x, quest2.y = 300, 560

	-- local function checkQuest2(quest)
	-- 	if (player.x > quest.x - 100 and player.x < quest.x + 100
	-- 		and player.y > quest.y - 100 and player.y < quest.y + 100) then

	-- 		composer.showOverlay("quest_temp")
	-- 		-- display.remove(quest)
	-- 	end
	-- end

	-- local function onEnterFrame(event)
 --    	checkQuest2(quest2)
	-- end

	-- Runtime:addEventListener("enterFrame", onEnterFrame)
	
	

	-- 퀘스트 반경 확인 --

	local function onEnterFrame(event)
    		if success.specialQ1 == "F" then
			checkQuest(quest1)
		end
		if success.q2 == "F" then
			checkQuest2(quest2Icon)
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
