if (proc_shop_kind == 1)
{
    if (global.proc_score >= proc_shop_price)
    {
        global.proc_score -= proc_shop_price;
        global.maxmissiles += 5;
        global.missiles = global.maxmissiles;
        global.mtanks += 1;
        with (oProcRoomRuntime)
        {
            shop_message = "MISSILES +5 PURCHASED";
            shop_message_timer = 150;
        }
        instance_destroy();
    }
    else
    {
        with (oProcRoomRuntime)
        {
            shop_message = "2200 PTS REQUIRED";
            shop_message_timer = 60;
        }
    }
    exit;
}
scr_missile_character_event();
