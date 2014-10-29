---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

-- local sceneName = ...

local composer 	= require( "composer" )
local widget 	= require( "widget" )
local data 		= require( "data" )
local navBar 	= require( "NavBar" )
local Text 		= require("Text")


-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

local tableView


----------------------------------------------------
-- This function draws the contents into each table cell
-- You need to create each display object, and insert it 
-- into the table "row" or cell. 
local function renderRow( event )
	local row = event.row	-- Get the row
	local index = row.index -- Get the index of the row
	
	----------------------------------------
	-- Title text
	local textLabel = Text.headingText( data.getDataAtIndex(index).assignment )
	textLabel.x = 15
	textLabel.y = 2
	row:insert( textLabel )
	-----------------------------------------
	-- Date text
	local date = data.getDataAtIndex(index).dateDue
	local datetext = Text.subheadText( date )
	datetext.x = 15
	datetext.y = 28
	row:insert( datetext )
	------------------------------------------
	-- Class text
	local classText = Text.captionText( data.getDataAtIndex(index).class )
	classText.anchorX = 1
	classText.anchorY = 0.5
	classText.x = display.contentWidth - 40
	classText.y = row.height / 2
	row:insert( classText )
	-----------------------------------------
	-- Arrow
	local arrow = display.newImageRect( "Line.png", 12, 32 )
	arrow.alpha = 0.5
	arrow.x = display.contentWidth - 14
	arrow.y = row.height / 2
	row:insert( arrow )
	
end
------------------------------------------------------------
-- This function handles touch events on table cells.
local function touchRow( event )
	if event.phase == "tap" then 
		local index = event.row.index 
		navBar.setTitle( data.getDataAtIndex(index).assignment )
		composer.gotoScene("TaskDetails", {effect="slideLeft", params={index=index}})
	end 
end 
------------------------------------------------------------
local function loadTableData()
	tableView:deleteAllRows()
	-- Now add some rows to the table view. 
    for i = 1, data.getCount() do 
    	tableView:insertRow( {
    		-- Set the height of each row. 
    		rowHeight=50,
    		-- Set the default and over color for the background of each row. 
    		rowColor = { default={ 0.1, 0.12, 0.2 }, over={ 0.0, 0.0, 0.0 } },
    		-- Set the line color
    		lineColor = { 0.22, 0.22, 0.3 }
    	} )
    end 
end 
---------------------------------------------------------------------------------

-- Create all scene display objects when this scene is created. 
-- You must add all display object to the scene's view with:
-- scene.view:insert( obj )

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    
    -- Create a tableView
    tableView = widget.newTableView({
    	hideBackground=true,
    	width=display.contentWidth,
    	height=display.contentHeight - 100,
    	left=0,
    	top=50,
    	onRowRender=renderRow,
    	onRowTouch=touchRow
    })
    
    -- Add the table view to this scene. 
    scene.view:insert( tableView )
    
end

--------------------------------------------------------------------------------

-- Show scene

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        -- Set the navbar title
        navBar.setTitle( "Assignments" )
        -- Clear any buttons on the navbar
        navBar.clearLeftBarButton()
        -- Add a button to the left of the navbar
        navBar.addRightBarButton( widget.newButton({
        	label="Add",
        	width=50,
        	height=50,
        	onRelease=function() 
        		composer.gotoScene("AddTask", {effect="slideLeft"}) 
        	end 
        }))
        
        loadTableData()
        
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
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
        
        -- Clear the button off the navbar
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
