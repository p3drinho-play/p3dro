if (proc_shop_kind == 2)
{
    if (global.proc_score >= proc_shop_price)
    {
        global.proc_score -= proc_shop_price;
        global.maxsmissiles += 2;
        global.smissiles = global.maxsmissiles;
        global.stanks += 1;
        with (oProcRoomRuntime)
        {
            shop_message = "SUPER MISSILES +2 PURCHASED";
            shop_message_timer = 150;
        }
        instance_destroy();
    }
    else
    {
        with (oProcRoomRuntime)
        {
            shop_message = "3900 PTS REQUIRED";
            shop_message_timer = 60;
        }
    }
    exit;
}
scr_supermissile_character_event();
