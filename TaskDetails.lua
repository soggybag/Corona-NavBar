---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

-- local sceneName = ...

local composer = require( "composer" )
local widget = require("widget")
local data = require("data")
local navBar = require("NavBar")
local Text = require("Text")

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

local class_text
local assignment_text
local date_text
local created_text


local function display_info( index )
	local dateCreated = data.getDataAtIndex(index).dateCreated
	local dateDue = data.getDataAtIndex(index).dateDue 
	local class = data.getDataAtIndex(index).class
	local assignment = data.getDataAtIndex(index).assignment
   
   class_text.text = class
   assignment_text.text = assignment
   date_text.text = dateDue
   created_text.text = dateCreated
end 


---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    
    local back = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    back:setFillColor( 44/255, 44/255, 44/255, 1 )
    scene.view:insert( back )
    
    
    class_text = Text.subheadText( "" )
    scene.view:insert( class_text ) 
    class_text.x = 20
    class_text.y = 90
    
    assignment_text = Text.headingText( "" )
    scene.view:insert( assignment_text )
    assignment_text.x = 20
    assignment_text.y = 110
    
    date_text = Text.captionText( "" )
    scene.view:insert( date_text )
    date_text.x = 20
    date_text.y = 170
    
    created_text = Text.captionText( "" )
    scene.view:insert( created_text )
    created_text.x = 20
    created_text.y = 200
	
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
		
		display_info( event.params.index )       
       
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        navBar.addBackButton()
        navBar.addLeftBarButton( widget.newButton({
        	label="Edit",
        	width=50,
        	height=50,
        	onRelease=function() 
        		composer.gotoScene("EditTask", {effect="slideLeft", params={index=event.params.index}}) 
        	end 
        }))
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        navBar.clearBarButtons()
        
    elseif phase == "did" then
        -- Called when the scene is now off screen
		
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
