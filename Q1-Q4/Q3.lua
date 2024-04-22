-- function removes a member from a specific player's party if the member is indeed in that player's party.

function removeFromPlayerParty(playerId, membername)
	player = Player(playerId)
	local party = player:getParty()
	
	for k,v in pairs(party:getMembers()) do
		-- to get the player from the player name you need to use getPlayerByName
		if v == getPlayerByName(membername) then
			-- removeMember is the guild remove function, the function for removing players from the party is leaveParty
			party:leaveParty(getPlayerByName(membername))
		end
	end
end