local composer = require( "composer" )
local scene = composer.newScene()

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		local score = event.params.score

        local ending
        if(100 <= score) then
            ending = display.newImageRect("image/엔딩/엔딩3.png", display.contentWidth, display.contentHeight)
        elseif 50 <= score then
            ending = display.newImageRect("image/엔딩/엔딩2.png", display.contentWidth, display.contentHeight)
        else
            ending = display.newImageRect("image/엔딩/엔딩1.png", display.contentWidth, display.contentHeight)
        end
        ending.x, ending.y = display.contentWidth/2, display.contentHeight/2

        local quit = display.newImage("image/엔딩/나가기.png")
        local regame = display.newImage("image/엔딩/재시작버튼.png")

        quit.width = 350
        quit.height = 180
        regame.width = 350
        regame.height = 180
        quit.x, quit.y = display.contentWidth*0.25, display.contentHeight*0.89
        regame.x, regame.y = display.contentWidth*0.75, display.contentHeight*0.89

        local function clickRegame(event)
            if event.phase == "ended" then
                display.remove(ending)
                display.remove(quit)
                display.remove(regame)
                composer.removeScene( "endingScene" )
                composer.gotoScene( "game" )
            
                --[[local event = { name = "newGameStart" }
                Runtime:dispatchEvent(event)]]
            end
        end

        local function clickQuit(event)
            if event.phase == "ended" then
                display.remove(ending)
                display.remove(quit)
                display.remove(regame)
                composer.removeScene( "endingScene" )
                composer.gotoScene("startScene")
            end
        end

        regame:addEventListener("touch", clickRegame)
        quit:addEventListener("touch", clickQuit)
    elseif phase == "did" then
	end	
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene