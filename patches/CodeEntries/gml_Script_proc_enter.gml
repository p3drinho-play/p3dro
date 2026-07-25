if (global.ingame != 1 || room == rm_transition || !instance_exists(oCharacter) || !instance_exists(oCamera))
{
    popup_text_ext("SEEDTROID: OPEN A SAVE FILE FIRST", 240);
    return 0;
}
if (global.proc_net_seed_ready)
{
    global.proc_seed = global.proc_net_seed;
}
else if (!instance_exists(oClient) || !oClient.connected)
{
    randomize();
    global.proc_seed = irandom(2147483646);
}
else
{
    global.proc_seed = proc_seed_load_for_save();
}
if (ds_exists(global.proc_path, ds_type_list))
{
    ds_list_destroy(global.proc_path);
}
if (ds_exists(global.proc_path_kinds, ds_type_list))
{
    ds_list_destroy(global.proc_path_kinds);
}
if (ds_exists(global.proc_path_x, ds_type_list))
{
    ds_list_destroy(global.proc_path_x);
}
if (ds_exists(global.proc_path_y, ds_type_list))
{
    ds_list_destroy(global.proc_path_y);
}
if (ds_exists(global.proc_visited_x, ds_type_list))
{
    ds_list_destroy(global.proc_visited_x);
}
if (ds_exists(global.proc_visited_y, ds_type_list))
{
    ds_list_destroy(global.proc_visited_y);
}
if (ds_exists(global.proc_edge_ax, ds_type_list))
{
    ds_list_destroy(global.proc_edge_ax);
}
if (ds_exists(global.proc_edge_ay, ds_type_list))
{
    ds_list_destroy(global.proc_edge_ay);
}
if (ds_exists(global.proc_edge_bx, ds_type_list))
{
    ds_list_destroy(global.proc_edge_bx);
}
if (ds_exists(global.proc_edge_by, ds_type_list))
{
    ds_list_destroy(global.proc_edge_by);
}
if (ds_exists(global.proc_open_edges, ds_type_map))
{
    ds_map_destroy(global.proc_open_edges);
}
if (!global.proc_net_seed_ready && ds_exists(global.proc_open_locks, ds_type_map))
{
    ds_map_destroy(global.proc_open_locks);
}
global.proc_path = ds_list_create();
global.proc_path_kinds = ds_list_create();
global.proc_path_x = ds_list_create();
global.proc_path_y = ds_list_create();
global.proc_visited_x = ds_list_create();
global.proc_visited_y = ds_list_create();
global.proc_edge_ax = ds_list_create();
global.proc_edge_ay = ds_list_create();
global.proc_edge_bx = ds_list_create();
global.proc_edge_by = ds_list_create();
global.proc_open_edges = ds_map_create();
if (!ds_exists(global.proc_open_locks, ds_type_map))
{
    global.proc_open_locks = ds_map_create();
}
ds_list_add(global.proc_path, 0);
ds_list_add(global.proc_path_kinds, 0);
ds_list_add(global.proc_path_x, 0);
ds_list_add(global.proc_path_y, 0);
ds_list_add(global.proc_visited_x, 0);
ds_list_add(global.proc_visited_y, 0);
if (!ds_exists(global.proc_peer_rooms, ds_type_map))
{
    global.proc_peer_rooms = ds_map_create();
}
if (ds_exists(global.proc_relic_rooms, ds_type_map))
{
    ds_map_destroy(global.proc_relic_rooms);
}
global.proc_relic_rooms = ds_map_create();
global.proc_score = 0;
global.proc_score_mult = 1;
global.proc_speed_mult = 1;
global.proc_item_bonus = 0;
global.proc_alpha_bonus = 0;
global.proc_regen_level = 0;
global.proc_regen_timer = 0;
global.proc_modifier_count = 0;
global.proc_combo_count = 0;
global.proc_combo_timer = 0;
global.proc_combo_mult = 1;
global.proc_relic_count = 0;
global.proc_run_complete = 0;
global.proc_return_room = room;
global.proc_return_x = oCharacter.x;
global.proc_return_y = oCharacter.y;
global.proc_return_cam_x = oCamera.x;
global.proc_return_cam_y = oCamera.y;
global.proc_room_index = 0;
global.proc_depth = 0;
global.proc_current_entry_kind = 0;
global.proc_entry_side = 0;
global.proc_active = 1;
global.proc_room_key = 0;
global.targetx = 64;
global.targety = 448;
global.camstartx = 160;
global.camstarty = 360;
global.offsetx = 0;
global.offsety = 0;
global.transitionx = global.targetx;
global.transitiony = global.targety;
with (oCharacter)
{
    xVel = 0;
    yVel = 0;
    xAcc = 0;
    yAcc = 0;
    visible = false;
}
popup_text_ext("SEEDTROID: CONTINUOUS WORLD - SEED " + string(global.proc_seed), 300);
room_change(411, 1);
Mute_Loops();
StopAmbLoops();
return 1;
