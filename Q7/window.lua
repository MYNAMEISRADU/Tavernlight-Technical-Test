function onSay(player, words, param)
	local window = ModalWindow(1000)

	window:addButton(100, "Jump!")

	window:sendToPlayer(player)
end