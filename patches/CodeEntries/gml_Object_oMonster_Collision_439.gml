if (state >= 1)
{
    if (state == 5)
    {
        if (proc_generated)
        {
            proc_last_hit_client = other.myid;
        }
        hp -= 8;
        flashing = 6;
        with (other.id)
        {
            event_user(0);
            if (!pbeam)
            {
                instance_destroy();
            }
        }
        event_user(0);
    }
    else if (other.ibeam)
    {
        state = 5;
        statetime = 0;
        PlaySoundMono(82);
        with (other.id)
        {
            event_user(0);
            if (!pbeam)
            {
                instance_destroy();
            }
        }
    }
    else
    {
        with (other.id)
        {
            event_user(1);
            if (!pbeam)
            {
                instance_destroy();
            }
        }
    }
}
