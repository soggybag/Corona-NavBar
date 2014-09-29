---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

-- local sceneName = ...

local composer = require( "composer" )
local data = require("data")
local navbar = require("NavBar")

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------


local function make_text( str )
	local txt = display.newText({text=str, font="Helvetica", size=24})
	txt.x = display.contentCenterX
	scene.view:insert( txt )
	
	return txt
end


---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    
    local index = event.params.index
    local dateCreated = data.getDataAtIndex(index).dateCreated
	local dateDue = data.getDataAtIndex(index).dateDue
	local class = data.getDataAtIndex(index).class
	local assignment = data.getDataAtIndex(index).assignment
    
    local class_text = make_text( class )
    class_text.y = 90
    
    local assignment_text = make_text( assignment )
    assignment_text.y = 130
    
    local date_text = make_text( dateDue )
    date_text.y = 170
	
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
       
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        navbar.addBackButton()
        
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
