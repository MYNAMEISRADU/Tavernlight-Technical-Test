local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.4) + 8
	local max = (level / 5) + (magicLevel * 2.2) + 14
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- function that checks the direction you're looking in and returns the position right in front of you.
function calculate_next_pos(direction, pos, amount)
    if direction == 0 then
         return Position(pos.x, pos.y - amount, pos.z)

    elseif direction == 1 then
         return Position(pos.x + amount, pos.y, pos.z)

    elseif direction == 2 then
         return Position(pos.x, pos.y + amount, pos.z)

    elseif direction == 3 then
         return Position(pos.x - amount, pos.y, pos.z)

    elseif direction == 4 then
         return Position(pos.x - amount, pos.y + amount, pos.z)

    elseif direction == 5 then
            return Position(pos.x + amount, pos.y + amount, pos.z)

    elseif direction == 6 then
            return Position(pos.x - amount, pos.y - amount, pos.z)

    elseif direction == 7 then
            return Position(pos.x + amount, pos.y - amount, pos.z)
    end
end

-- function that handles dash logic, takes in the player, his direction and the length of the dash.
function dash(cid, direction, amount)
	local player = Player(cid)
	local pos = player:getPosition()
	local tempPos = pos

	-- this for loop checks if the tiles in front are available to be walked on, otherwise teleports you as far as you can go.
	for i = 1, amount do
		local nextPos = calculate_next_pos(direction, pos, i)
		local tile = Tile(nextPos)
		if not tile:isWalkable() then
			player:teleportTo(tempPos, true)
			return false
		end
		tempPos = nextPos
	end

	local newPos = calculate_next_pos(direction, pos, amount)
	player:teleportTo(newPos, true)
end


function onCastSpell(creature, variant)
	local direction = creature:getDirection()
	
	-- this for loop does multiple dashes in a row of decreasing length to make it a gradual movement instead of sudden.
	for i = 1, 3 do
        addEvent(dash, 100 * i, creature:getId(), direction, 5-i)
    end

	return combat:execute(creature, variant)
end
