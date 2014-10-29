---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local composer 	= require( "composer" )
local navBar 	= require( "NavBar" )
local widget 	= require( "widget" )
local data 		= require( "data" )
local text		= require( "text" )

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

-- TODO: 
-- Add to calendar on phone
-- http://coronalabs.com/blog/2014/05/20/tutorial-adding-events-to-the-devices-calendar-ios/

local inputName
local inputClass
local date_picker

---------------------------------------------------------------

local function add_new_task() 
	local date = date_picker:getValues()
	local dateDue = date[2].value .. " " .. date[1].value .. " " .. date[3].value
	local name = inputName.textField.text

	data.addNewTask( dateDue, name )
end

---------------------------------------------------------------
local function on_input_name(event) 
	-- Handle text input from text fields.
end
----------------------------------------------------------
-- Use this function to make a date picker. 
local function make_date_picker()
	-- Create two tables to hold data for days and years      
	local days = {}
	local years = {}

	-- Populate the "days" table
	for d = 1, 31 do
		days[d] = d
	end

	-- Populate the "years" table
	for y = 1, 48 do
		years[y] = 1969 + y
	end

	-- Configure the picker wheel columns
	local columnData = 
	{
		-- Months
		{ 
			align = "right",
			width = 120,
			startIndex = 5,
			labels = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
		},
		-- Days
		{
			align = "center",
			width = 60,
			startIndex = 18,
			labels = days
		},
		--[[ Hour
		{
			align = "center",
			width = 60,
			startIndex = 6,
			labels = {1,2,3,4,5,6,7,8,9,10,11,12}
		},
		-- AM PM
		{
			align = "center",
			width = 60,
			startIndex = 1,
			labels = {"AM","PM"}
		},]]
		-- Years
		{
			align = "center",
			width = 80,
			startIndex = 10,
			labels = years
		}
	}

	-- Create the widget
	local pickerWheel = widget.newPickerWheel
	{
		top = display.contentHeight - 222,
		columns = columnData
	}

	-- Get the table of current values for all columns
	-- This can be performed on a button tap, timer execution, or other event
	local values = pickerWheel:getValues()

	-- Get the value for each column in the wheel (by column index)
	local currentMonth = values[1].value
	local currentDay = values[2].value
	local currentYear = values[3].value

	print( currentMonth, currentDay, currentYear )
	
	scene.view:insert(pickerWheel)
	return pickerWheel
end 


------------------------------------------------------
-- Create this scene
function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist

    inputName = text.make_input( "name", on_input_name )
    sceneGroup:insert( inputName )
    inputName.y = 80
    inputClass = text.make_input( "class", on_input_name )
    sceneGroup:insert( inputClass )
    inputClass.y = 135
    
    date_picker = make_date_picker()
end
----------------------------------------------------------------------------------
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- Add the back button
        navBar.addBackButton()
        -- Add Save button
        navBar.addRightBarButton( widget.newButton({
        	label="Save",
        	width=50,
        	height=50,
        	onRelease=function() 
        		add_new_task()
        		composer.gotoScene("ViewTasks", {effect="slideRight"}) 
        	end 
        }) )
        -- Set nav bar title 
        navBar.setTitle( "New Task" ) 
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
