-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

local function onFirstView( event )
	local gameScene = require("startScene")
	composer.gotoScene( "startScene" )
end

onFirstView()
