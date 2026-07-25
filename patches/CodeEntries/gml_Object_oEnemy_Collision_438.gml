if (canbehit && !(!other.smissile && global.icemissiles))
{
    if (stun == 0 && hitmissileexpl)
    {
        if (proc_generated)
        {
            proc_last_hit_client = other.myid;
        }
        event_user(0);
    }
    if (myhealth <= 0 && frozen == 0)
    {
        state = 100;
    }
    if (myhealth <= 0 && frozen)
    {
        enemy_death_frozen();
        global.kills += 1;
    }
}
