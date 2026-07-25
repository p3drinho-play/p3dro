if (canbehit)
{
    if (hitbeam && other.dohit)
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
        if (myhealth <= 0 && frozen)
        {
            enemy_death_frozen();
            global.kills += 1;
        }
    }
    else
    {
        if (proc_generated)
        {
            proc_last_hit_client = other.myid;
        }
        myhealth -= 1;
        flashing = 6;
        flashtime = 6;
    }
    if (other.pbeam == 0)
    {
        with (other.id)
        {
            instance_destroy();
        }
    }
}
