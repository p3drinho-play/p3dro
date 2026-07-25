if (encounter_kind == 2)
{
    global.event[307] = boss_event_307_restore;
}
if (ds_exists(solid_grid, ds_type_grid))
{
    ds_grid_destroy(solid_grid);
}
if (ds_exists(lock_ids, ds_type_list))
{
    proc_lock_clear(lock_ids);
    ds_list_destroy(lock_ids);
}
if (ds_exists(branch_gate_ids, ds_type_list))
{
    proc_lock_clear(branch_gate_ids);
    ds_list_destroy(branch_gate_ids);
}
if (ds_exists(enemy_ids, ds_type_list))
{
    ds_list_destroy(enemy_ids);
}
if (ds_exists(door_visual_ids, ds_type_list))
{
    ds_list_destroy(door_visual_ids);
}
if (ds_exists(shop_item_ids, ds_type_list))
{
    ds_list_destroy(shop_item_ids);
}
