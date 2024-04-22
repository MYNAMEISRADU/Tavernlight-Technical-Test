-- The function works as intended if our intent is to set the storage at index 1000 to -1 when the player logs out, with a delay of 1 second.
-- I'm mostly questioning the need of a one second delay in the first place, and whether or not we want the functions to be limited to one use case.
-- If it were for me I would add an input parameter for which storage index we want to manipulate
local function releaseStorage(player, index)
	-- I would add an if statement here to check whether the index is within bounds that are useful to us, still
	player:setStorageValue(index, -1)
end
	
function onLogout(player)
	if player:getStorageValue(1000) == 1 then
		addEvent(releaseStorage, 1000, player, 1000)
	end
return true
end