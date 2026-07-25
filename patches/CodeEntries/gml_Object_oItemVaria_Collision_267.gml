if (proc_shop_kind == 5)
{
    if (global.proc_score >= proc_shop_price)
    {
        global.proc_score -= proc_shop_price;
        global.proc_modifier_count += 1;
        switch (proc_shop_modifier_kind)
        {
            case 0:
                global.proc_speed_mult *= 1.025;
                break;
            case 1:
                global.proc_score_mult += 0.1;
                break;
            case 2:
                global.maxhealth += 50;
                global.playerhealth = global.maxhealth;
                break;
            case 3:
                global.maxmissiles += 5;
                global.missiles = global.maxmissiles;
                break;
            case 4:
                global.proc_item_bonus += 1;
                break;
            case 5:
                global.proc_alpha_bonus += 1;
                break;
            case 6:
                global.proc_regen_level += 1;
                break;
        }
        with (oProcRoomRuntime)
        {
            shop_message = "MODIFIER PURCHASED";
            shop_message_timer = 180;
        }
        instance_destroy();
    }
    else
    {
        with (oProcRoomRuntime)
        {
            shop_message = "10000 PTS REQUIRED";
            shop_message_timer = 60;
        }
    }
    exit;
}
event_inherited();
global.SuitChange = 1;
if (collision_line(x + 8, y - 8, x + 8, y - 32, oSolid, false, true))
{
    global.SuitChange = 0;
}
if (!collision_point(x + 8, y + 8, oSolid, 0, 1))
{
    global.SuitChange = 0;
}
if (global.saxmode)
{
    global.SuitChange = 0;
}
global.SuitChangeX = x;
global.SuitChangeY = y;
global.SuitChangeGravity = 0;
if (active)
{
    with (oCharacter)
    {
        alarm[1] = 1;
    }
    if (instance_exists(oClient) && oClient.connected)
    {
        popup_text(get_text("Items", "VariaSuit") + " " + get_text("GlobalOptions", "Enabled"));
        with (oClient)
        {
            event_user(8);
        }
    }
}
