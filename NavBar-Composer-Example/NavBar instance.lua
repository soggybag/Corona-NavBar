local M = display.newGroup()
----------------

local back
local bar_center_x
local bar_center_y
local bar_width
local bar_height
local group = M
local title_array = {}

local font_size = 18
local font = "Helvetica"

local title = "NavBar"

local title_color = {r=1,g=1,b=1,a=1}




----------------------------------------
-- Set the bar style here 
--------------------------------------
local function make_bar( w, h, color )
	-- Set the bar color 
	local color = color or {r=0,g=0,b=0,a=1}
	
	bar_width = display.contentWidth or w
	bar_height = h or 40
	local bar = display.newRect( 0, 0, bar_width, bar_height )
	
	bar_center_x = bar_width * 0.5
	bar_center_y = bar_height * 0.5
	
	bar.anchorX = 0
	bar.anchorY = 0
	
	bar:setFillColor( color.r, color.g, color.b, color.a )
	
	return bar
end 




------------------------------------
-- Set the style for the title here
------------------------------------


--------------
local function get_view()
	return group
end 
M.get_view = get_view
---------------
local function set_title( str )
	title = str
	make_title( str ) 
end 
M.set_title = set_title
--------------
local function set_font( the_font )
	font = the_font
	make_title( title ) 
end
M.set_font = set_font
--------------
local function bar_color( red, green, blue, alpha )
	local r = red or 1
	local g = green or 1
	local b = blue or 1
	local a = alpha or 1
	
	back:setFillColor( r, g, b, a )
end 
M.bar_color = bar_color
-------------
local function title_color( red, green, blue, alpha )
	local r = red or 1
	local g = green or 1
	local b = blue or 1
	local a = alpha or 1
	title_color = {r=r, g=g, b=b, a=a}
end 
M.title_color = title_color



-----------------------------------
local function newNavBar( options )
	local navBar = display.newGroup()
	
	navBar.back = make_bar( options.width, options.height, options.color )
	navBar.title = options.title
	navBar.titleColor = options.titleColor
	
	navBar.title_array = {}
	
	navBar:insert(navBar.back)
	
	function navBar:setTitle( str ) 
		-- Set the font and size here 
		self.title = str
		local title = display.newText( str, 0, 0, "Helvetica", 18 )
		-- set the color here 
		title:setFillColor( self.titleColor.r, self.titleColor.g, self.titleColor.b, self.titleColor.a )
		title.x = bar_width
		title.y = bar_center_y
		title.alpha = 0
		self:insert( title )
		if self.title_array[1] ~= nil then 
			transition.to( table.remove( self.title_array, 1 ), {x=0, alpha=0, transition=easing.inExpo,
			onComplete=function( title )
				display.remove( title )
			end } )
		end 
		self.title_array[#title_array+1] = title
	
		transition.to( title, {x=bar_center_x, alpha=1, transition=easing.outExpo, delay=1000} )
	end 
	
	return navBar
end 
M.newNavBar = newNavBar


--------------
return M