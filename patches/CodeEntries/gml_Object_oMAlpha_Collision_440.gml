if (canbehit)
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
