if (proc_shop_kind == 4)
{
    if (global.proc_score >= proc_shop_price)
    {
        global.proc_score -= proc_shop_price;
        global.maxpbombs += 2;
        global.pbombs = global.maxpbombs;
        global.ptanks += 1;
        with (oProcRoomRuntime)
        {
            shop_message = "POWER BOMBS +2 PURCHASED";
            shop_message_timer = 150;
        }
        instance_destroy();
    }
    else
    {
        with (oProcRoomRuntime)
        {
            shop_message = "6600 PTS REQUIRED";
            shop_message_timer = 60;
        }
    }
    exit;
}
scr_powerbomb_character_event();
