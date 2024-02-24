-----------------------------------------------------------------------------------------
--
-- quest_alien.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
 	local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*0.85, display.contentHeight*0.75, 55)
 	background.strokeWidth = 10
	background:setStrokeColor( 0.6 )
 	background:setFillColor(1, 1, 0.9 )

 	local title = display.newText("외계인 침공", display.contentWidth/2, display.contentHeight*0.2)
 	title:setFillColor( 0.6 )
 	title.size = 70

 	local player = display.newImage("image/캐릭터_총.png")
 	player.height = 300
	player.width = 300
	player.x, player.y = 1700, 600

 	----- 외계인 스페셜 퀘스트 --------
 	local function moveAlien(alien)
	    local destX = math.random(display.contentWidth/2)
	    local destY = math.random(display.contentHeight/2)
	    
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
	        player = display.newImage("image/캐릭터_총.png")
	        player.x, player.y = display.contentWidth * 0.16, display.contentHeight * 0.3

	        createAliens(4)
	    end
	    return true
	end

	background:addEventListener("touch", onAcceptTouch)




 	function title:tap( event )
 		--
 	end
 	title:addEventListener("tap", title)

 	-- sceneGroup:insert(background)
 	-- sceneGroup:insert(title)
 	-- sceneGroup:insert(accept)
 	-- sceneGroup:insert(alien)
 	-- sceneGroup:insert(player)
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