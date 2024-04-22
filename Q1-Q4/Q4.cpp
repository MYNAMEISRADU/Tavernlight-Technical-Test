void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{

    Player* player = g_game.getPlayerByName(recipient);

    if (!player)
    {
        //if the player doesn't exist creating a new null player does not accomplish anything, and it also would not have any login data since it was just created.
//        player = new Player(nullptr);
//        
//        if (!IOLoginData::loadPlayerByName(player, recipient)) {
//            return;
//        }
        return;
    }

    Item* item = Item::CreateItem(itemId);

    if (!item)
    {
        //we need to delete the item if it's not useful
        delete item
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }

}