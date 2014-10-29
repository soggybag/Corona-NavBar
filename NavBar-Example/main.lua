-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Test the navbar 

local widget = require("widget")
local navBar = require("NavBar") -- Load the nav bar

-----------------------------------------------------------------------------------------

-- Set the title of the nav bar. call navBar.setTitle("new title string")

navBar.setTitle( "Hello" )	-- Set the title 


-----------------------------------------------------------------------------------------

-- Make a button that changes the title. Change the title any time. 

local button_1 = widget.newButton({
	label="New Title",
	x=display.contentCenterX,
	y=120,
	onRelease=function()
		navBar.setTitle("New Title") -- Set the title
	end
})

-----------------------------------------------------------------------------------------

-- Make a button that adds a button to the right side of the nav bar.
-- Add a button to the nav abr with navBar.addRightBarButton( buttonObject )
-- Note: buttonObject can be nay display object. 
-- Add an event listener to buttonObject to handle taps on that button. 

local button_2 = widget.newButton({
	label="Add",
	x=display.contentCenterX,
	y=160,
	onRelease=function()
		-- Add a button to the right of the nav bar
		navBar.addRightBarButton( widget.newButton({
			label="Add",
			width=50,							-- Be sure to set the width to something reasonable. 
			onRelease=function() 				-- Give the button an action
				navBar.clearRightBarButton()	-- Clicking the button will clear the button from the nav bar
			end 
		}) )
	end
})

-----------------------------------------------------------------------------------------

-- Make a button that adds a button to the left side of the nav bar.
-- Adds a button to the left side of the bar. 

local button_3 = widget.newButton({
	label="Cancel",
	x=display.contentCenterX,
	y=200,
	onRelease=function()
		-- Add a button to the right of the nav bar
		navBar.addLeftBarButton( widget.newButton({
			label="Cancel",
			width=50,							-- Be sure to set the width to something reasonable. 
			onRelease=function() 				-- Give the button an action
				navBar.clearLeftBarButton()		-- Clicking the button will clear the button from the nav bar
			end 
		}) )
	end
})

-----------------------------------------------------------------------------------------

-- Make a button that clears both bar buttons

local button_4 = widget.newButton({
	label="Clear buttons",
	x=display.contentCenterX,
	y=240,
	onRelease=function()
		-- Add a button to the right of the nav bar
		navBar.clearBarButtons()
	end
})

-----------------------------------------------------------------------------------------

-- Make a button that adds a button to the right side of the nav bar.
-- Note that adding a new button to the nav bar clears an existing button.
local button_5 = widget.newButton({
	label="Info",
	x=display.contentCenterX,
	y=280,
	onRelease=function()
		-- Add a button to the right of the nav bar
		navBar.addRightBarButton( widget.newButton({
			label="Info",
			width=50,							-- Be sure to set the width to something reasonable. 
			onRelease=function() 				-- Give the button an action
				navBar.clearRightBarButton()	-- Clicking the button will clear the button from the nav bar
			end 
		}) )
	end
})

-----------------------------------------------------------------------------------------

-- Make a button that adds a button to the right side of the nav bar.
-- Note that adding a new button to the nav bar clears an existing button.
local button_6 = widget.newButton({
	label="More",
	x=display.contentCenterX,
	y=320,
	onRelease=function()
		-- Add a button to the right of the nav bar
		navBar.addLeftBarButton( widget.newButton({
			label="More",
			width=50,							-- Be sure to set the width to something reasonable. 
			onRelease=function() 				-- Give the button an action
				navBar.clearLeftBarButton()	-- Clicking the button will clear the button from the nav bar
			end 
		}) )
	end
})

-----------------------------------------------------------------------------------------

-- You can add any display object to the bar. Here I added rect shape. You could also 
-- add a picture. 

local button_7 = widget.newButton({
	label="Box",
	x=display.contentCenterX,
	y=360,
	onRelease=function()
		-- Create a rect to add to the nav bar. 
		local box = display.newRect( 0, 0, 30, 30 )	-- Make a new rect 30 by 30
		box:setFillColor(1, 0, 0)					-- Set the fill color to red
		local function tap_box(event)				-- Define a function to handle taps on the box
			navBar.clearBarButtons()
		end 
		box:addEventListener("tap", tap_box)
		navBar.addLeftBarButton( box )
	end
})


