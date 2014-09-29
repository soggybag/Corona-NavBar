---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

-- local sceneName = ...

local composer = require( "composer" )
local widget = require( "widget" )
local data = require( "data" )
local navBar = require( "NavBar" )


-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

local tableView

local function renderRow( event )
	local row = event.row
	local index = row.index 
	
	local textLabel = display.newText({
		text= data.getDataAtIndex(index).assignment,
		font="Helvetica",
		fontSize=20
	}) 
	
	textLabel:setFillColor(0.3,0.3,0.3)
	textLabel.anchorX = 0
	textLabel.anchorY = 0
	textLabel.x = 15
	textLabel.y = 0
	row:insert( textLabel )
	
	local subtext = display.newText({
		text = data.getDataAtIndex(index).dateDue,
		font="Helvetica",
		fontSize=14
	})
	
	subtext:setFillColor(0.4,0.4,0.4)
	subtext.anchorX = 0
	subtext.anchorY = 0
	subtext.x = 15
	subtext.y = 28
	row:insert( subtext )
end


local function touchRow( event )
	if event.phase == "tap" then 
		local index = event.row.index 
		navBar.setTitle( data.getDataAtIndex(index).assignment )
		composer.gotoScene("scene2", {effect="slideLeft", params={index=index}})
	end 
end 

---------------------------------------------------------------------------------


function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    
    tableView = widget.newTableView({
    	width=display.contentWidth,
    	height=display.contentHeight - 100,
    	left=0,
    	top=50,
    	onRowRender=renderRow,
    	onRowTouch=touchRow
    })
    
    scene.view:insert( tableView )
    
    for i = 1, data.getCount() do 
    	tableView:insertRow( {rowHeight=50} )
    end 
    
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
        
        navBar.setTitle( "Assignments" )
        navBar.clearRightBarButton()
        
        navBar.addLeftBarButton( widget.newButton({
        	label="Add",
        	width=50,
        	height=50,
        	onRelease=function() 
        		composer.gotoScene("scene3", {effect="slideLeft"}) 
        	end 
        }) )
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
		navBar.clearLeftBarButton()
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
