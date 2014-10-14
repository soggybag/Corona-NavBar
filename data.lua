local M = {}
--------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
local data 		= {}
local classes 	= {}

local function HomeworkItem() 
	local names_array = {"make", "cool", "stuff"}
	homeworkItem 				= {}
	-- homeworkItem.dateCreated 	= os.time()
	homeworkItem.dateCreated 	= os.date( "%A %l:%M%p", os.time() )
	-- homeworkItem.dateDue 		= os.time()
	homeworkItem.dateDue 		= os.date( "%A %l:%M%p", os.time() )
	homeworkItem.class 			= "WNM " .. math.random(1,3) .. math.random(0, 6) .. math.random(0,9)
	local name 					= names_array[math.random(1, #names_array)] .. " " .. names_array[math.random(1, #names_array)] .. " " .. names_array[math.random(1, #names_array)]
	homeworkItem.assignment 	= name
	
	return homeworkItem
end 
--------------------------------------
local function addNewTask( dateDue, name )
	local newTask = HomeworkItem() 
	newTask.dateDue = dateDue
	newTask.assignment = name
	data[#data+1] = newTask
end 
M.addNewTask = addNewTask




----------------------------
-- Make some default items
for i = 1, 20 do 
	data[i] = HomeworkItem()
end 
----------------------------
local function getData()
	return data
end 
M.getData = getData
-------------------------------------
local function getDataAtIndex(index)
	return data[index]
end 
M.getDataAtIndex = getDataAtIndex
-------------------------------------
local function getCount()
	return #data
end
M.getCount = getCount
--------------------------------------------------------------------------------
return M