if (canbehit)
{
    if (stun == 0 && hitpbomb)
    {
        if (proc_generated)
        {
            proc_last_hit_client = other.myid;
        }
        event_user(0);
    }
    if (myhealth <= 0)
    {
        state = 100;
    }
}
