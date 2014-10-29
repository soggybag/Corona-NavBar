local M = display.newGroup()
----------------


local widget = require("widget")		-- Import widget for use with buttons
local composer = require("composer")	-- Import composer for the back button

------------------------------------
-- Make some variables
------------------------------------

local back
local bar_center_x
local bar_center_y
local bar_width = display.contentWidth
local bar_height = 50
local group = M

local title_array = {}

local font = "Helvetica"
local fontSize = 18
local fontColor = {r=22/255, g=22/255, b=22/255, a=1}
local backColor = {r=222/255, g=222/255, b=222/255, a=1}

local rightBarButton
local leftBarButton



----------------------------------------------
-- Private functions 
----------------------------------------------


----------------------------------------
-- Set the bar style here 
--------------------------------------
local function make_bar( w, h, color )
	-- Set the bar color 
	local color = {r=0,g=0,b=0,a=1} or color

	bar_width = bar_width
	bar_height = bar_height
	local bar = display.newRect( 0, 0, bar_width, bar_height )
	
	bar_center_x = bar_width * 0.5
	bar_center_y = bar_height * 0.5
	
	bar.anchorX = 0
	bar.anchorY = 0
	
	bar:setFillColor( backColor.r, backColor.g, backColor.b, backColor.a )
	group:insert( bar )
	
	return bar
end 

------------------------------------
-- Set the style for the title here
------------------------------------


local function make_title( str ) 
	-- Set the font and size here 
	local title = display.newText( str, 0, 0, font, fontSize )
	-- set the color here 
	title:setFillColor( fontColor.r, fontColor.g, fontColor.b, fontColor.a )
	title.x = bar_width
	title.y = bar_center_y
	title.alpha = 0
	group:insert( title )
	if title_array[1] ~= nil then 
		transition.to( table.remove( title_array, 1 ), {x=0, alpha=0, transition=easing.inExpo,
		onComplete=function( title )
			display.remove( title )
		end } )
	end 
	title_array[#title_array+1] = title
	
	transition.to( title, {x=bar_center_x, alpha=1, transition=easing.outExpo, delay=1000} )
end 

back = make_bar()

--------------------







-------------------------------------
-- Public functions 
-------------------------------------


---------------------------------
-- get_view()
-- returns the group object
local function get_view()
	return group
end 
M.get_view = get_view
---------------------------------
-- setTitle( titleString ) 
-- Sets the title displayed in the center of the nav bar. 
local function setTitle( str )
	make_title( str ) 
end 
M.setTitle = setTitle
---------------------------------
-- clearRightBarButton()
-- Clears the right bar button
local function clearRightBarButton()
	if rightBarButton then 
		transition.to( rightBarButton, {x=display.contentWidth+50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		rightBarButton = nil
	end 
end 
M.clearRightBarButton = clearRightBarButton
---------------------------
-- clearLeftBarButton()
-- Clear the left bar button
local function clearLeftBarButton()
	if leftBarButton then 
		transition.to( leftBarButton, {x=-50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		leftBarButton = nil
	end 
end 
M.clearLeftBarButton = clearLeftBarButton
---------------------------
-- clearBarButtons()
-- Clear both the left and right bar buttons. 
local function clearBarButtons()
	clearRightBarButton()
	clearLeftBarButton()
end 
M.clearBarButtons = clearBarButtons
---------------------------
-- addRightBarButton( buttonObject )
-- Adds a button object to the right of the bar. The buttonObject can be a widget button
-- or a display object of any type. If there is a button on the right, that button is 
-- removed when a new button is added. 
local function addRightBarButton( button )
	clearRightBarButton()
	rightBarButton = button
	group:insert(button)
	button.y = bar_height / 2
	button.x = display.contentWidth + button.width / 2
	transition.to( button, {x=display.contentWidth - button.width/2-10, time=200} )
end 
M.addRightBarButton = addRightBarButton
-----------------------------
-- addLeftBarButton( buttonObject )
-- Adds a button to the left of the bar. 
local function addLeftBarButton( button )
	clearLeftBarButton()
	leftBarButton = button
	group:insert(button)
	button.y = bar_height / 2
	button.x = button.width / -2
	transition.to( button, {x=button.width/2+10, time=200} )
end 
M.addLeftBarButton = addLeftBarButton
-----------------------------
-- addBackButton()	
-- Adds a button, labeled: Back, to the right 
local function addBackButton()	
	addLeftBarButton( widget.newButton( {
		width=50,
		height=bar_height,
		label="Back",
		onRelease=function() composer.gotoScene( composer.getSceneName( "previous" ), {effect="slideRight"} )  end
	} ) )
end 
M.addBackButton = addBackButton
--------------------------------
-- 
local function setBarColor(r, g, b, a)
	back:setFillColor( r or 1, g or 1, b or 1, a or 1)
end 
M.setBarColor = setBarColor






--------------
return M