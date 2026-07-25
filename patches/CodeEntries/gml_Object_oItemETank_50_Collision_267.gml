if (proc_shop_kind == 3)
{
    if (global.proc_score >= proc_shop_price)
    {
        global.proc_score -= proc_shop_price;
        global.maxhealth += (100 * oControl.mod_etankhealthmult);
        global.playerhealth = global.maxhealth;
        global.etanks += 1;
        with (oProcRoomRuntime)
        {
            shop_message = "ENERGY TANK PURCHASED";
            shop_message_timer = 150;
        }
        instance_destroy();
    }
    else
    {
        with (oProcRoomRuntime)
        {
            shop_message = "4400 PTS REQUIRED";
            shop_message_timer = 60;
        }
    }
    exit;
}
scr_energytank_character_event();
