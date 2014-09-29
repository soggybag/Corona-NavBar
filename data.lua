local M = {}
--------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
local data = {}

local function HomeworkItem() 
	local names_array = {"make", "cool", "stuff"}

	homeworkItem = {}
	homeworkItem.dateCreated = os.time()
	homeworkItem.dateDue = os.time()
	homeworkItem.class = "WNM " .. math.random(1,3) .. math.random(0, 6) .. math.random(0,9)
	local name = names_array[math.random(1, #names_array)] .. " " .. names_array[math.random(1, #names_array)] .. " " .. names_array[math.random(1, #names_array)]
	homeworkItem.assignment = name
	
	return homeworkItem
end 

for i = 1, 20 do 
	data[i] = HomeworkItem()
end 

local function getData()
	return data
end 
M.getData = getData

local function getDataAtIndex(index)
	return data[index]
end 
M.getDataAtIndex = getDataAtIndex

local function getCount()
	return #data
end
M.getCount = getCount
--------------------------------------------------------------------------------
return M