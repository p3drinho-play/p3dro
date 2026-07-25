if (proc_generated && proc_spawn_index >= 0 && !proc_death_sent && global.proc_active && instance_exists(oClient) && oClient.connected)
{
    proc_death_sent = 1;
    var _proc_death_buffer = buffer_create(32, buffer_grow, 1);
    buffer_write(_proc_death_buffer, buffer_s32, 0);
    buffer_write(_proc_death_buffer, buffer_u8, 128);
    buffer_write(_proc_death_buffer, buffer_u8, global.clientID);
    buffer_write(_proc_death_buffer, buffer_f64, proc_room_key);
    buffer_write(_proc_death_buffer, buffer_u8, proc_spawn_index);
    buffer_poke(_proc_death_buffer, 0, buffer_s32, buffer_tell(_proc_death_buffer) - 4);
    network_send_packet(oClient.socket, _proc_death_buffer, buffer_tell(_proc_death_buffer));
    buffer_delete(_proc_death_buffer);
}
if (global.proc_active && proc_generated)
{
    var _proc_award_local = 1;
    if (instance_exists(oClient) && oClient.connected)
    {
        _proc_award_local = proc_last_hit_client == global.clientID;
    }
    if (_proc_award_local)
    {
        var _proc_base_score = 100;
        if (proc_elite)
        {
            _proc_base_score = 500;
        }
        global.proc_combo_count += 1;
        global.proc_combo_timer = room_speed * 4;
        global.proc_combo_mult = min(5, 1 + (floor(global.proc_combo_count / 3) * 0.25));
        global.proc_score += floor(_proc_base_score * global.proc_score_mult * global.proc_combo_mult);
    }
}
spawn_rnd_pickup(100);
PlaySoundMono(210);
if (instance_exists(platform))
{
    with (platform)
    {
        instance_destroy();
    }
}
repeat (8)
{
    deb = instance_create(x, y - 8, oIceShard);
}
if (global.waterlevel != 0 && (y + 8) > (global.waterlevel + global.wateroffset))
{
    repeat (8 + floor(random(4)))
    {
        bubble = instance_create(x, y, oLBubble);
        if (instance_exists(bubble))
        {
            bubble.hspeed = random_range(-1.5, 1.5);
            bubble.vspeed = -random(0.4);
        }
    }
}
instance_destroy();
