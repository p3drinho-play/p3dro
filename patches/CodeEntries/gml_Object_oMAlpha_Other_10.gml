if (other.smissile == 1)
{
    dmg = 50;
    flashtime = 60;
}
else
{
    dmg = 10;
    flashtime = 30;
}
myhealth -= dmg;
if (myhealth <= 0)
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
    state = 100;
    statetime = 0;
    alarm[10] = 1;
    alarm[11] = 160;
    flashtime = 180;
    turndelay = 180;
    PlaySoundMono(deathsound);
    global.metdead[myid] = 1;
    global.monstersleft -= 1;
    global.monstersarea -= 1;
    check_areaclear();
    global.monstersalive -= 1;
    if (global.monstersalive == 0)
    {
        mus_fadeout(259);
        oMusicV2.bossbgm = 0;
    }
    with (oMAlpha)
    {
        event_user(2);
    }
    global.dmap[mapposx, mapposy] = 11;
    with (oControl)
    {
        event_user(2);
    }
    dead = 1;
}
flashing = 1;
canbehit = 0;
statetime = 0;
currentangle = 30;
if (chasing == 0)
{
    chasing = 1;
    alarm[3] = awaydelay;
}
if (myhealth > 0)
{
    PlaySoundMono(hitsound);
}
if (sfx_isplaying(130))
{
    sfx_stop(130);
}
