---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require( "composer" )

-- load scene1
composer.gotoScene( "scene1" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)


----------------------------------------------------------------------------------
local widget = require( "widget" )

local function onTabBar( event )
	print( event.target.label.text )
	
	if event.target.label.text == "List" then 
		composer.gotoScene("scene1", {effect="slideUp"})
	elseif event.target.label.text == "two" then 
		composer.gotoScene("scene4", {effect="slideUp"})
	end 
end 

local buttons = {
	{id="list", label="List", size=12, onPress=onTabBar, selected=true},
	{id="two", label="two", size=12, onPress=onTabBar},
	{id="three", label="three", size=12, onPress=onTabBar}
}

local tabBar = widget.newTabBar({
	buttons=buttons,
	width=display.contentWidth,
	height=50,
	top=display.contentHeight - 50
})



-----------------------------------------------------------------------------------
local navBar = require("NavBar")

--[[
.newNavBar( {
	width=display.contentWidth,
	height=50,
	color={r=222/255, g=222/255, b=222/255, a=1},
	titleColor={r=22/255, g=22/255, b=22/255, a=1}
} )

--]]

navBar.setTitle( "Task List" )
























