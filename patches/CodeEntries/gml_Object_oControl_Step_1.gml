if (init)
{
    exit;
}
if (global.proc_respawn_pending && global.ingame == 1 && room != rm_transition && room != rm_death && instance_exists(oCharacter) && instance_exists(oCamera))
{
    global.proc_respawn_pending = 0;
    global.proc_active = 1;
    global.proc_room_index = 0;
    global.proc_room_key = 0;
    global.proc_depth = 0;
    global.proc_current_entry_kind = 0;
    global.proc_entry_side = 0;
    if (ds_exists(global.proc_path, ds_type_list))
    {
        ds_list_clear(global.proc_path);
        ds_list_add(global.proc_path, 0);
    }
    if (ds_exists(global.proc_path_kinds, ds_type_list))
    {
        ds_list_clear(global.proc_path_kinds);
        ds_list_add(global.proc_path_kinds, 0);
    }
    if (ds_exists(global.proc_path_x, ds_type_list))
    {
        ds_list_clear(global.proc_path_x);
        ds_list_add(global.proc_path_x, 0);
    }
    if (ds_exists(global.proc_path_y, ds_type_list))
    {
        ds_list_clear(global.proc_path_y);
        ds_list_add(global.proc_path_y, 0);
    }
    global.enablecontrol = 0;
    with (oCharacter)
    {
        xVel = 0;
        yVel = 0;
        xAcc = 0;
        yAcc = 0;
        visible = false;
    }
    room_change(411, 1);
    Mute_Loops();
    StopAmbLoops();
    exit;
}
if (instance_exists(oClient) && oClient.connected && !global.proc_net_requested)
{
    global.proc_net_requested = 1;
    proc_net_request_state();
}
if (global.proc_net_seed_ready && global.proc_net_applied_revision != global.proc_net_revision)
{
    proc_net_apply_state();
}
if (global.ingame == 1 && !global.proc_active && !global.proc_auto_entered && room != rm_transition && instance_exists(oCharacter) && instance_exists(oCamera))
{
    if (!instance_exists(oClient) || !oClient.connected)
    {
        global.proc_auto_entered = 1;
        proc_enter();
        exit;
    }
}
if (keyboard_check_pressed(vk_f9) && global.proc_active && (!instance_exists(oClient) || !oClient.connected))
{
    proc_next_seed();
    exit;
}
if ((os_type == os_android || os_type == os_linux) && global.joydetected == 0)
{
    for (var i = 0; i < gamepad_get_device_count(); i++)
    {
        if (gamepad_is_connected(i))
        {
            for (var ia = 0; ia < gamepad_button_count(i); ia++)
            {
                if (gamepad_button_check(i, ia))
                {
                    global.opjoyid = i;
                    global.joydetected = 1;
                }
            }
            for (var ia = 0; ia < gamepad_axis_count(i); ia++)
            {
                if (gamepad_axis_value(i, ia) != 0)
                {
                    global.opjoyid = i;
                    global.joydetected = 1;
                }
            }
        }
    }
}
if (widescreen)
{
    widescreen_space = 106;
}
else
{
    widescreen_space = 0;
    view_visible[1] = false;
}
if (global.saxmode)
{
    global.grayMap = 1;
}
else
{
    global.grayMap = 0;
}
if (global.event[308] > 0 && room != rm_credits)
{
    if (global.winningTeam == 0 && !is_on_menu() && handleGameEnd)
    {
        if (gameEndTimer == 5)
        {
            if (instance_exists(oCharacter))
            {
                with (oCharacter)
                {
                    facing = 0;
                    if (global.currentsuit == 0)
                    {
                        sprite_index = scr_suit_sprites(822, 1157);
                    }
                    if (global.currentsuit == 1)
                    {
                        sprite_index = scr_suit_sprites(1029, 1157);
                    }
                    if (global.currentsuit == 2)
                    {
                        sprite_index = scr_suit_sprites(848, 1157);
                    }
                    global.enablecontrol = 0;
                    canbehit = 0;
                    oControl.displaygui = 0;
                    xVel = 0;
                    yVel = 0;
                    xAcc = 0;
                    yAcc = 0;
                }
            }
            popup_text_ext("Ship reached", 120);
        }
        if (gameEndTimer == 120)
        {
            oControl.displaygui = 0;
            global.enablecontrol = 0;
            if (instance_exists(oCharacter))
            {
                with (oCharacter)
                {
                    xVel = 0;
                    yVel = 0;
                    xAcc = 0;
                    yAcc = 0;
                }
            }
        }
        if (gameEndTimer == 420)
        {
            instance_create(0, 0, oFinalFadeout);
            mus_fadeout(292);
            global.enablecontrol = 0;
            if (instance_exists(oCharacter))
            {
                with (oCharacter)
                {
                    xVel = 0;
                    yVel = 0;
                    xAcc = 0;
                    yAcc = 0;
                }
            }
        }
        gameEndTimer++;
    }
    if (global.winningTeam == 1 || is_on_menu() || gameEndTimer == 760)
    {
        global.endingGametime = global.gametime;
        global.endingItemstaken = global.itemstaken;
        global.event[308] = 0;
        remove_persistent_objects();
        sfx_stop_all();
        global.vibL = 0;
        global.vibR = 0;
        global.ingame = 0;
        global.darkness = 0;
        global.gotolog = -1;
        global.enablecontrol = 1;
        global.transitiontype = 0;
        oControl.displaygui = 1;
        room_goto(rm_credits);
        mus_stop_all();
        mus_play_once(293);
    }
}
