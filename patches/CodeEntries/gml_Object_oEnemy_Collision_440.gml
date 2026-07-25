if (canbehit)
{
    if (hitmissile)
    {
        if (proc_generated)
        {
            proc_last_hit_client = other.myid;
        }
        event_user(0);
        with (other.id)
        {
            event_user(0);
        }
    }
    else if (object_index == oMeboid || object_index == oMeboid2)
    {
        if ((other.object_index == oMissile || other.object_index == oMissileExpl) && global.icemissiles && !other.smissile)
        {
            if (proc_generated)
            {
                proc_last_hit_client = other.myid;
            }
            event_user(0);
            with (other.id)
            {
                event_user(0);
            }
        }
        else
        {
            with (other.id)
            {
                event_user(1);
            }
        }
    }
    else
    {
        with (other.id)
        {
            event_user(1);
        }
    }
    if (myhealth <= 0 && frozen)
    {
        enemy_death_frozen();
        global.kills += 1;
    }
}
