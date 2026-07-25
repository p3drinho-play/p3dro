if (hp <= 0)
{
    if (global.proc_active && proc_generated)
    {
        var _proc_award_local = 1;
        if (instance_exists(oClient) && oClient.connected)
        {
            _proc_award_local = proc_last_hit_client == global.clientID;
        }
        if (_proc_award_local)
        {
            global.proc_combo_count += 1;
            global.proc_combo_timer = room_speed * 4;
            global.proc_combo_mult = min(5, 1 + (floor(global.proc_combo_count / 3) * 0.25));
            global.proc_score += floor(100 * global.proc_score_mult * global.proc_combo_mult);
        }
    }
    if (proc_generated && proc_spawn_index >= 0 && !proc_net_dead_sent && global.proc_active && instance_exists(oClient) && oClient.connected)
    {
        proc_net_dead_sent = 1;
        var _proc_monster_buffer = buffer_create(40, buffer_grow, 1);
        buffer_write(_proc_monster_buffer, buffer_s32, 0);
        buffer_write(_proc_monster_buffer, buffer_u8, 130);
        buffer_write(_proc_monster_buffer, buffer_u8, global.clientID);
        buffer_write(_proc_monster_buffer, buffer_f64, proc_room_key);
        buffer_write(_proc_monster_buffer, buffer_u8, proc_spawn_index);
        buffer_write(_proc_monster_buffer, buffer_u8, state);
        buffer_write(_proc_monster_buffer, buffer_s16, round(x));
        buffer_write(_proc_monster_buffer, buffer_s16, round(y));
        buffer_write(_proc_monster_buffer, buffer_s16, 0);
        buffer_write(_proc_monster_buffer, buffer_u8, 1);
        buffer_poke(_proc_monster_buffer, 0, buffer_s32, buffer_tell(_proc_monster_buffer) - 4);
        network_send_packet(oClient.socket, _proc_monster_buffer, buffer_tell(_proc_monster_buffer));
        buffer_delete(_proc_monster_buffer);
    }
    repeat (10)
    {
        expl = instance_create((x - 16) + random(32), (y - 16) + random(32), oFXAnimSpark);
        expl.image_speed = 0.5 + random(0.5);
        expl.additive = 0;
        expl.sprite_index = sExpl1;
        expl.direction = random(360);
        expl.speed = 2 + random(1);
    }
    repeat (20)
    {
        deb = instance_create(x, y - 8, oIceShard);
    }
    make_explosion4(x, y);
    instance_create(x, y, oScreenFlash);
    sfx_play(86);
    PlaySoundMono(210);
    sfx_play(171);
    global.monstersleft -= 1;
    global.monstersarea -= 1;
    if (global.monstersarea < 1)
    {
        global.monstersarea = 1;
    }
    if (global.monstersleft < 1)
    {
        global.monstersleft = 1;
    }
    if (myid >= 0 && myid <= 98)
    {
        if (myid >= 0 && myid <= 98)
        {
            global.metdead[myid] = 1;
        }
    }
    with (oMonsterDoorControl)
    {
        alarm[1] = 1;
    }
    var pickup = choose(0, 1);
    if (pickup == 0)
    {
        if (global.missiles < global.maxmissiles && global.maxmissiles > 0)
        {
            repeat (3)
            {
                instance_create(x + random_range(-15, 15), y + random_range(-15, 15), oMPickup);
            }
        }
        else
        {
            pickup = 1;
        }
    }
    if (pickup == 1)
    {
        if (global.smissiles < global.maxsmissiles && global.maxsmissiles > 0)
        {
            instance_create(x, y, oSMPickup);
        }
    }
    if (global.playerhealth < global.maxhealth && (oControl.mod_insanitymode == 0 || (global.difficulty < 2 && oControl.mod_insanitymode == 1)))
    {
        repeat (3)
        {
            instance_create(x + random_range(-15, 15), y + random_range(-15, 15), oHPickupBig);
        }
    }
    if (room == rm_a7b08A && instance_number(oMonster) == 1)
    {
        if (global.monstersleft != 1)
        {
            global.monstersleft = 1;
        }
        if (global.monstersarea != 1)
        {
            global.monstersarea = 1;
        }
        instance_create(0, 0, oBigQuakeQueen);
    }
    instance_destroy();
}
else
{
    flashing = 20;
    sfx_play(170);
}
