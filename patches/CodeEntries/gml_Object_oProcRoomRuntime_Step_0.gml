if (!global.proc_active)
{
    exit;
}
if (global.proc_depth >= 1000 && !global.proc_run_complete)
{
    global.proc_run_complete = 1;
    if (!global.sax)
    {
        global.proc_active = 0;
        global.proc_room_key = -1;
        global.waterlevel = 0;
        global.watertype = 0;
        global.event[303] = 0;
        global.targetx = 192;
        global.targety = 448;
        global.camstartx = 160;
        global.camstarty = 360;
        global.transitionx = global.targetx;
        global.transitiony = global.targety;
        with (oCharacter)
        {
            xVel = 0;
            yVel = 0;
            xAcc = 0;
            yAcc = 0;
            visible = false;
        }
        popup_text_ext("RUN COMPLETE - QUEEN BATTLE", 300);
        room_change(368, 1);
        Mute_Loops();
        StopAmbLoops();
        exit;
    }
    else
    {
        popup_text_ext("RUN COMPLETE - SA-X REMAINS IN SEEDTROID", 300);
    }
}
instance_activate_all();
if (transition_lock > 0)
{
    transition_lock -= 1;
}
live_enemy_count = proc_enemy_alive_count(enemy_ids);
if (global.proc_combo_timer > 0)
{
    global.proc_combo_timer -= 1;
}
else if (global.proc_combo_count > 0)
{
    global.proc_combo_count = max(0, global.proc_combo_count - 1);
    global.proc_combo_mult = min(5, 1 + (floor(global.proc_combo_count / 3) * 0.25));
    global.proc_combo_timer = room_speed;
}
if (encounter_kind == 1 && !metroid_bonus_awarded)
{
    if (global.playerhealth < metroid_last_health)
    {
        metroid_bonus_eligible = 0;
    }
    metroid_last_health = global.playerhealth;
}
if (environment_active)
{
    if (environment_lava_delay > 0)
    {
        environment_lava_delay -= 1;
    }
    else
    {
        global.waterlevel = max(96, global.waterlevel - 1.5);
    }
}
if (shop_message_timer > 0)
{
    shop_message_timer -= 1;
}
if (global.proc_regen_level > 0 && global.playerhealth < global.maxhealth)
{
    global.proc_regen_timer += 1;
    if (global.proc_regen_timer >= max(30, room_speed * 5))
    {
        global.proc_regen_timer = 0;
        global.playerhealth = min(global.maxhealth, global.playerhealth + global.proc_regen_level);
    }
}
if (0 && shop_active && instance_exists(oCharacter))
{
    if (keyboard_check_pressed(ord("1")))
    {
        if (global.proc_score >= 2200)
        {
            global.proc_score -= 2200;
            global.maxmissiles += 5;
            global.missiles = global.maxmissiles;
            global.mtanks += 1;
            shop_message = "MISSILES PURCHASED";
        }
        else
        {
            shop_message = "NOT ENOUGH POINTS";
        }
        shop_message_timer = 120;
    }
    if (keyboard_check_pressed(ord("2")))
    {
        if (global.proc_score >= 3900)
        {
            global.proc_score -= 3900;
            global.maxsmissiles += 2;
            global.smissiles = global.maxsmissiles;
            global.stanks += 1;
            shop_message = "SUPER MISSILES PURCHASED";
        }
        else
        {
            shop_message = "NOT ENOUGH POINTS";
        }
        shop_message_timer = 120;
    }
    if (keyboard_check_pressed(ord("3")))
    {
        if (global.proc_score >= 4400)
        {
            global.proc_score -= 4400;
            global.maxhealth += (100 * oControl.mod_etankhealthmult);
            global.playerhealth = global.maxhealth;
            global.etanks += 1;
            shop_message = "ENERGY TANK PURCHASED";
        }
        else
        {
            shop_message = "NOT ENOUGH POINTS";
        }
        shop_message_timer = 120;
    }
    if (keyboard_check_pressed(ord("4")))
    {
        if (global.proc_score >= 6600)
        {
            global.proc_score -= 6600;
            global.maxpbombs += 2;
            global.pbombs = global.maxpbombs;
            global.ptanks += 1;
            shop_message = "POWER BOMBS PURCHASED";
        }
        else
        {
            shop_message = "NOT ENOUGH POINTS";
        }
        shop_message_timer = 120;
    }
    if (keyboard_check_pressed(ord("5")))
    {
        if (global.proc_score >= 10000)
        {
            global.proc_score -= 10000;
            var _modifier_kind = proc_stream_seed(global.proc_seed, 1601 + global.proc_modifier_count, global.proc_room_index) % 7;
            global.proc_modifier_count += 1;
            switch (_modifier_kind)
            {
                case 0:
                    global.proc_speed_mult *= 1.025;
                    shop_message = "MOD: SPEED +2.5%";
                    break;
                case 1:
                    global.proc_score_mult += 0.1;
                    shop_message = "MOD: SCORE +10%";
                    break;
                case 2:
                    global.maxhealth += 50;
                    global.playerhealth = global.maxhealth;
                    shop_message = "MOD: MAX ENERGY +50";
                    break;
                case 3:
                    global.maxmissiles += 5;
                    global.missiles = global.maxmissiles;
                    shop_message = "MOD: MISSILE CAPACITY +5";
                    break;
                case 4:
                    global.proc_item_bonus += 1;
                    shop_message = "MOD: UPGRADE CHANCE +1%";
                    break;
                case 5:
                    global.proc_alpha_bonus += 1;
                    shop_message = "MOD: MORE METROIDS";
                    break;
                case 6:
                    global.proc_regen_level += 1;
                    shop_message = "MOD: REGENERATION +1";
                    break;
            }
        }
        else
        {
            shop_message = "NOT ENOUGH POINTS";
        }
        shop_message_timer = 180;
    }
}
if (encounter_kind == 2 && live_enemy_count == 0)
{
    global.event[307] = boss_event_307_restore;
}
if (encounter_kind == 1 && live_enemy_count == 0 && !metroid_bonus_awarded)
{
    metroid_bonus_awarded = 1;
    if (metroid_bonus_eligible)
    {
        global.proc_score += floor(1500 * global.proc_score_mult * global.proc_combo_mult);
        popup_text_ext("FLAWLESS METROID +1500", 240);
    }
}
if (lock_active)
{
    lock_timer += 1;
    lock_kills_done = max(0, enemy_count - live_enemy_count);
    lock_kills_remaining = max(0, lock_kill_goal - lock_kills_done);
    if (lock_kills_remaining == 0)
    {
        lock_active = 0;
        proc_lock_clear(lock_ids);
        ds_map_add(global.proc_open_locks, string(global.proc_room_index), 1);
        if (instance_exists(oClient) && oClient.connected)
        {
            proc_net_unlock_room(global.proc_room_index);
        }
        popup_text_ext("LOCKDOWN CLEARED - DOORS OPEN", 180);
    }
}
if (spawn_pending && instance_exists(oCharacter))
{
    with (oCharacter)
    {
        x = other.spawn_x;
        y = other.spawn_y;
        xVel = 0;
        yVel = 0;
        xAcc = 0;
        yAcc = 0;
        visible = true;
    }
    if (instance_exists(oCamera))
    {
        with (oCamera)
        {
            x = global.camstartx;
            y = global.camstarty;
            targetx = global.camstartx;
            targety = global.camstarty;
            snapx = 0;
            snapy = 0;
            ratiox = 4;
            ratioy = 4;
        }
    }
    global.enablecontrol = 1;
    spawn_pending = 0;
}
if (transition_lock <= 0 && !spawn_pending && !lock_active && instance_exists(oCharacter))
{
    if (left_slot >= 0 && oCharacter.x <= 40 && oCharacter.y >= (left_floor_y - 56) && oCharacter.y <= (left_floor_y + 8))
    {
        proc_travel(-1);
        exit;
    }
    if (oCharacter.x >= 1240 && oCharacter.y >= (main_floor_y - 56) && oCharacter.y <= (main_floor_y + 8))
    {
        proc_travel(1);
        exit;
    }
    if (branch_slot >= 0 && !branch_gate_locked && oCharacter.x >= 1240 && oCharacter.y >= (branch_floor_y - 56) && oCharacter.y <= (branch_floor_y + 8))
    {
        proc_travel(2);
        exit;
    }
}
