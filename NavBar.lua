local M = display.newGroup()
----------------


local widget = require("widget")
local composer = require("composer")


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


--------------
local function get_view()
	return group
end 
M.get_view = get_view

local function setTitle( str )
	make_title( str ) 
end 
M.setTitle = setTitle

--------------------------

local function clearRightBarButton()
	if rightBarButton then 
		transition.to( rightBarButton, {x=-50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		rightBarButton = nil
	end 
end 
M.clearRightBarButton = clearRightBarButton

---------------------------

local function clearLeftBarButton()
	if leftBarButton then 
		transition.to( leftBarButton, {x=display.contentWidth+50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		leftBarButton = nil
	end 
end 
M.clearLeftBarButton = clearLeftBarButton

---------------------------

local function addRightBarButton( button )
	if rightBarButton then 
		transition.to( rightBarButton, {x=-50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		rightBarButton = nil
	end
	
	rightBarButton = button
	
	group:insert(button)
	
	button.y = bar_height / 2
	button.x = button.width / -2
	
	transition.to( button, {x=button.width/2+10, time=200} )
end 
M.addRightBarButton = addRightBarButton

-----------------------------

local function addLeftBarButton( button )
	if leftBarButton then 
		transition.to( leftBarButton, {x=-50, time=200, onComplete=function(target)
			display.remove(target)
		end} )
		leftBarButton = nil
	end
	
	leftBarButton = button
	
	group:insert(button)
	
	button.y = bar_height / 2
	button.x = display.contentWidth + button.width / 2
	
	transition.to( button, {x=display.contentWidth - button.width/2-10, time=200} )
end 
M.addLeftBarButton = addLeftBarButton

-----------------------------

local function addBackButton()	
	addRightBarButton( widget.newButton( {
		width=50,
		height=bar_height,
		label="Back",
		onRelease=function() composer.gotoScene( composer.getSceneName( "previous" ), {effect="slideRight"} )  end
	} ) )
end 
M.addBackButton = addBackButton







--------------
return M