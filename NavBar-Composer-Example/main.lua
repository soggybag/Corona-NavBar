---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require( "composer" )

-- load first scene
composer.gotoScene( "ViewTasks" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)
----------------------------------------------------------------------------------
-- Use widget to create a tabbar
local widget = require( "widget" )

-- This function will handle taps on tab bar buttons
local function onTabBar( event )
	print( event.target.label.text )
	
	if event.target.label.text == "Tasks" then 
		composer.gotoScene("ViewTasks", {effect="slideUp"})
	elseif event.target.label.text == "Classes" then 
		composer.gotoScene("Classes", {effect="slideUp"})
	elseif event.target.label.text == "Schedule" then 
		composer.gotoScene("Schedule", {effect="slideUp"})
	end 
end 

-- Describe some tabbar buttons
local buttons = {
	{id="list", label="Tasks", size=12, onPress=onTabBar, selected=true},
	{id="two", label="Classes", size=12, onPress=onTabBar},
	{id="three", label="Schedule", size=12, onPress=onTabBar}
}

-- Make a tab bar
local tabBar = widget.newTabBar({
	buttons=buttons,
	width=display.contentWidth,
	height=50,
	top=display.contentHeight - 50
})

-----------------------------------------------------------------------------------
-- Import the NavBar. There is only one nav bar. 
local navBar = require("NavBar")
-- Set the title on the nav bar. 
navBar.setTitle( "Task List" )

-- Set the background color of the nav bar. 
-- navBar.setBarColor(r, g, b, a)
-- navBar.setBarColor(1, .3, .6)
-- If you want to use an image make an image, position it behind the nav bar, and make
-- the nav bar transparent. navBar.setBarColor(1, 1, 1, 0)

















