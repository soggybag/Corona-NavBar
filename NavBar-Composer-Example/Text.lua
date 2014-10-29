-- Text.lua 
-- Factory for text objects
-- Generates text objects with styles used in a project. 
-----------------------------------------------------------
local M = {}
-----------------------------------------------------------
local FONT = "Helvetica Neue LT Std 45 Light"
local HEADLINE_FONT = "Helvetica Neue LT Std 45 Light"
local BODY_FONT_SIZE = 16
local CAPTION_FONT_SIZE = 11
local HEADLINE_FONT_SIZE = 18
local SUBHEAD_FONT_SIZE = 14
local FONT_COLOR = {0.9,0.9,0.9}
local HEADLINE_FONT_COLOR = {0.7, 0.8, 1.0}
----------------------------------------------------------
local function makeText( text, font, fontSize, color )
	local textLabel = display.newText( {
		text=text,
		font=font,
		fontSize=fontSize,
		
	} )
	textLabel:setFillColor( color[1], color[2], color[3] )
	textLabel.anchorX = 0
	textLabel.anchorY = 0
	return textLabel
end 
M.makeText = makeText
-----------------------------------------------------------
local function bodyText( text )
	return makeText( text, FONT, BODY_FONT_SIZE, FONT_COLOR )
end
M.bodyText = bodyText
-----------------------------------------------------------
local function captionText( text )
	return makeText( text, FONT, CAPTION_FONT_SIZE, FONT_COLOR )
end
M.captionText = captionText
-----------------------------------------------------------
local function headingText( text )
	return makeText( text, HEADLINE_FONT, HEADLINE_FONT_SIZE, HEADLINE_FONT_COLOR )
end
M.headingText = headingText
-----------------------------------------------------------
local function subheadText( text )
	return makeText( text, FONT, SUBHEAD_FONT_SIZE, FONT_COLOR )
end
M.subheadText = subheadText
-------------------------------------------------------------
-- Use this function to make input fields. 
local function make_input( placeholder, listener )
	local input_group = display.newGroup()
	local input_back = display.newRect( 0, 0, display.contentWidth - 20, 40 )
	input_back:setFillColor( 220/255, 220/255, 220/255 )
	
	local input_text = native.newTextField( 0, 0, display.contentWidth - 20, 40 )
	input_text:addEventListener( 'userInput', listener )
	
	input_text:setTextColor(160/255, 160/255, 160/255 )
	input_text.size = 17
	input_text.font = native.newFont("Helvetica", 17)
	input_text.align = "center"
	input_text.placeholder = placeholder
	input_text.hasBackground = false
	input_text.y = 8
	
	input_group:insert( input_back )
	input_group:insert( input_text )
	
	input_group.textField = input_text
	
	input_group.x = display.contentCenterX
	input_group.y = 100
	
	return input_group
end 
M.make_input = make_input

-----------------------------------------------------------
return M