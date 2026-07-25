damagemissiles = global.mod_monstersDmissiles;
damagesupermissiles = global.mod_monstersDsuper;
if (state >= 1)
{
    if (!other.smissile && global.icemissiles)
    {
        state = 5;
        statetime = 0;
        PlaySoundMono(82);
        with (other.id)
        {
            event_user(0);
        }
    }
    if (state != 5)
    {
        if (!global.icemissiles)
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
            event_user(0);
        }
        if (other.smissile == 1)
        {
            if (proc_generated)
            {
                proc_last_hit_client = other.myid;
            }
            hp -= damagesupermissiles;
        }
        else
        {
            if (proc_generated)
            {
                proc_last_hit_client = other.myid;
            }
            hp -= damagemissiles;
        }
        event_user(0);
    }
}
