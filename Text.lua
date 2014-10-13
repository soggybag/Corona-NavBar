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
-----------------------------------------------------------
return M