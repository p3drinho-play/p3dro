if ((other.object_index == oMissile || other.object_index == oMissileExpl) && global.icemissiles && !other.smissile)
{
    if (canfreeze)
    {
        if ((other.damage > myhealth && !frozen) || (ceil(other.damage / 2) > myhealth && !frozen))
        {
            dmg = 0;
            myhealth = 1;
        }
        else
        {
            dmg = other.damage;
        }
        frozen = 240;
    }
    else
    {
        dmg = other.damage;
    }
}
else
{
    dmg = other.damage;
}
if (global.difficulty == 2)
{
    dmg = ceil(dmg / 2);
}
if (justfrozen == 0)
{
    myhealth -= dmg;
}
if (myhealth <= 0 && justfrozen == 0 && state != 100)
{
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
    state = 100;
    statetime = 0;
    global.kills += 1;
}
stun = stuntime;
if (other.ibeam && frozen == 0 && canfreeze && myhealth < freezehp)
{
    event_user(15);
}
if (canflash)
{
    flashing = 5;
    fxtimer = 0;
}
if (frozen)
{
    if (myhealth > 0)
    {
        PlaySoundMono(82);
    }
}
else
{
    PlaySoundMono(hitsound);
}
