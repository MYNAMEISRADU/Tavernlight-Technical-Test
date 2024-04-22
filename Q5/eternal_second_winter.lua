local combats = {}
-- array of spell areas that will be cast in successive order
local areas = {
	{{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 0, 0, 1, 0},
	{0, 0, 0, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 1, 0, 0, 0},
	{0, 0, 3, 0, 0},
	{0, 1, 0, 0, 0},
	{0, 0, 0, 0, 0}},

	{{0, 1, 0, 0, 0},
	{0, 0, 0, 0, 0},
	{0, 1, 3, 1, 0},
	{0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 0, 0, 0, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 1, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 1, 0, 1, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 0, 1, 0},
	{1, 0, 3, 0, 1},
	{0, 0, 0, 1, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 1, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 1, 0, 0, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 1, 0, 1, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 0, 1, 0},
	{1, 0, 3, 0, 1},
	{0, 0, 0, 1, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 1, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 1, 0, 0, 0},
	{0, 0, 1, 0, 0}},

	{{0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0},
	{1, 0, 3, 0, 1},
	{0, 1, 0, 1, 0},
	{0, 0, 1, 0, 0}},
}

-- for loop to set the area for each successive cast
for i = 1, #areas do
	combats[i] = Combat()
	combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	combats[i]:setArea(createCombatArea(areas[i]))

	function onGetFormulaValues(player, level, magicLevel)
		local min = (level / 5) + (magicLevel * 5.5) + 25
		local max = (level / 5) + (magicLevel * 11) + 50
		return -min, -max
	end

	combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

-- create a function to execute the spell at the specified area index
local function castSpell(creatureId, variant, combatIndex)
    local creature = Creature(creatureId)
    if creature then
        combats[combatIndex]:execute(creature, variant)
    end
end

-- for loop to add event with an increasing delay for casting the spell. It returns the first instance of the spell being cast.
function onCastSpell(creature, variant)
	for i = 1, #areas do
        addEvent(castSpell, 250 * i, creature:getId(), variant, i)
    end
    return combats[1]:execute(creature, variant)
end
