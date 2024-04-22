function printSmallGuildNames(memberCount)
	-- this method is supposed to print names of all guilds that have less than memberCount max members
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
	-- resultId returns a boolean value with the outcome of the storequery, so we first make sure that the storeQuery is successful
	if resultId then
		local guildName = result.getString("name")
		print(guildName)
	end
	-- then we return the outcome of the print
	return resultId
end