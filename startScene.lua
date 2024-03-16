
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
    local start = display.newImageRect("image/자료2/시작화면.png", display.contentWidth, display.contentHeight)
    start.x, start.y = display.contentWidth/2, display.contentHeight/2
    local quit = display.newImage("image/자료2/나가기.png")
    local protect = display.newImage("image/자료2/게임시작.png")
    quit.width = 350
    quit.height = 180
    protect.width = 350
    protect.height = 180
    quit.x, quit.y = display.contentWidth*0.25, display.contentHeight*0.89
    protect.x, protect.y = display.contentWidth*0.75, display.contentHeight*0.89

    local function clickProtect(event)
        if event.phase == "ended" then
            display.remove(start)
            display.remove(quit)
            display.remove(protect)
            composer.removeScene( "startScene" )
            composer.gotoScene( "game" )
            
            --[[local event = { name = "newGameStart" }
            Runtime:dispatchEvent(event)]]
        end
    end

    local function clickQuit(event)
        if event.phase == "ended" then
            os.exit()
        end
    end

    protect:addEventListener("touch", clickProtect)
    quit:addEventListener("touch", clickQuit)
end

scene:addEventListener( "create", scene )

return scene