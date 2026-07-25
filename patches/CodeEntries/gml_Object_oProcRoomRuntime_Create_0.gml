global.waterlevel = 0;
global.watertype = 0;
global.darkness = 0;
global.floormaterial = 1;
global.offsetx = 0;
global.offsety = 0;
global.proc_room_key = global.proc_room_index;
if (instance_exists(oClient) && oClient.connected)
{
    proc_net_send_room(global.proc_room_index);
}
if (!ds_exists(global.proc_open_edges, ds_type_map))
{
    global.proc_open_edges = ds_map_create();
}
if (!ds_exists(global.proc_open_locks, ds_type_map))
{
    global.proc_open_locks = ds_map_create();
}
shop_active = global.proc_depth > 0 && (global.proc_depth % 25) == 0;
environment_active = !shop_active && global.proc_depth > 10 && (global.proc_depth % 45) != 0 && (proc_stream_seed(global.proc_seed, 1901, global.proc_room_index) % 100) < 10;
environment_lava_delay = room_speed * 2;
shop_item_ids = ds_list_create();
shop_modifier_kind = proc_stream_seed(global.proc_seed, 1601 + global.proc_modifier_count, global.proc_room_index) % 7;
tiles_w = 80;
tiles_h = 60;
tile_size = 16;
solid_grid = ds_grid_create(tiles_w, tiles_h);
if (shop_active)
{
    ds_grid_clear(solid_grid, 0);
    for (var _shop_floor_x = 0; _shop_floor_x < tiles_w; _shop_floor_x += 1)
    {
        ds_grid_set(solid_grid, _shop_floor_x, 0, 1);
        ds_grid_set(solid_grid, _shop_floor_x, 1, 1);
        ds_grid_set(solid_grid, _shop_floor_x, 58, 1);
        ds_grid_set(solid_grid, _shop_floor_x, 59, 1);
    }
    for (var _shop_wall_y = 2; _shop_wall_y < 54; _shop_wall_y += 1)
    {
        ds_grid_set(solid_grid, 0, _shop_wall_y, 1);
        ds_grid_set(solid_grid, 1, _shop_wall_y, 1);
        ds_grid_set(solid_grid, 78, _shop_wall_y, 1);
        ds_grid_set(solid_grid, 79, _shop_wall_y, 1);
    }
}
else
{
    proc_geometry_build(solid_grid, global.proc_seed, global.proc_room_index, global.proc_room_count);
}
collision_count = proc_collision_build(solid_grid);
enemy_ids = ds_list_create();
lock_ids = ds_list_create();
branch_gate_ids = ds_list_create();
door_visual_ids = ds_list_create();
encounter_kind = 0;
boss_event_307_restore = global.event[307];
enemy_count = 0;
item_count = 0;
if (!shop_active)
{
    if (!environment_active)
    {
        encounter_kind = proc_encounter_kind(global.proc_seed, global.proc_room_index, global.proc_depth);
        enemy_count = proc_encounter_build(solid_grid, global.proc_seed, global.proc_room_index, global.proc_depth, enemy_ids, encounter_kind);
    }
    item_count = proc_item_build(global.proc_seed, global.proc_room_index, global.proc_depth);
}
live_enemy_count = enemy_count;
lock_kill_goal = enemy_count;
lock_kills_done = 0;
lock_kills_remaining = lock_kill_goal;
metroid_bonus_eligible = encounter_kind == 1;
metroid_bonus_awarded = 0;
metroid_last_health = global.playerhealth;
shop_message_timer = 0;
shop_message = "";
if (environment_active)
{
    global.watertype = 1;
    global.waterlevel = room_height + 64;
}
if (!ds_exists(global.proc_relic_rooms, ds_type_map))
{
    global.proc_relic_rooms = ds_map_create();
}
if (global.proc_depth > 0 && (global.proc_depth % 80) == 0 && !shop_active && !environment_active && encounter_kind == 0)
{
    var _relic_key = string(global.proc_room_index);
    if (!ds_map_exists(global.proc_relic_rooms, _relic_key))
    {
        ds_map_add(global.proc_relic_rooms, _relic_key, 1);
        global.proc_relic_count += 1;
        var _relic_kind = proc_stream_seed(global.proc_seed, 2001, global.proc_room_index) % 7;
        switch (_relic_kind)
        {
            case 0:
                global.proc_speed_mult *= 1.015;
                popup_text_ext("RELIC: SWIFT CORE - SPEED +1.5%", 240);
                break;
            case 1:
                global.proc_score_mult += 0.05;
                popup_text_ext("RELIC: GOLDEN CORE - SCORE +5%", 240);
                break;
            case 2:
                global.maxhealth += 25;
                global.playerhealth = global.maxhealth;
                popup_text_ext("RELIC: LIFE CORE - MAX ENERGY +25", 240);
                break;
            case 3:
                global.maxmissiles += 3;
                global.missiles = global.maxmissiles;
                popup_text_ext("RELIC: WAR CORE - MISSILE CAPACITY +3", 240);
                break;
            case 4:
                global.proc_item_bonus += 1;
                popup_text_ext("RELIC: TREASURE CORE - UPGRADE CHANCE +1%", 240);
                break;
            case 5:
                global.proc_alpha_bonus += 1;
                popup_text_ext("RELIC: HUNTER CORE - MORE METROIDS", 240);
                break;
            case 6:
                global.proc_regen_level += 1;
                popup_text_ext("RELIC: RECOVERY CORE - REGENERATION +1", 240);
                break;
        }
    }
}
if (shop_active)
{
    var _shop_missile = instance_create(256, 896, oItemM_52);
    _shop_missile.proc_shop_kind = 1;
    _shop_missile.proc_shop_price = 2200;
    _shop_missile.proc_shop_label = "MISSILES +5 - 2200 PTS";
    ds_list_add(shop_item_ids, _shop_missile);
    var _shop_super = instance_create(448, 896, oItemSM_51);
    _shop_super.proc_shop_kind = 2;
    _shop_super.proc_shop_price = 3900;
    _shop_super.proc_shop_label = "SUPER MISSILES +2 - 3900 PTS";
    ds_list_add(shop_item_ids, _shop_super);
    var _shop_etank = instance_create(640, 896, oItemETank_50);
    _shop_etank.proc_shop_kind = 3;
    _shop_etank.proc_shop_price = 4400;
    _shop_etank.proc_shop_label = "ENERGY TANK - 4400 PTS";
    ds_list_add(shop_item_ids, _shop_etank);
    var _shop_pbomb = instance_create(832, 896, oItemPB_58);
    _shop_pbomb.proc_shop_kind = 4;
    _shop_pbomb.proc_shop_price = 6600;
    _shop_pbomb.proc_shop_label = "POWER BOMBS +2 - 6600 PTS";
    ds_list_add(shop_item_ids, _shop_pbomb);
    var _shop_modifier = instance_create(1024, 896, oItemVaria);
    _shop_modifier.proc_shop_kind = 5;
    _shop_modifier.proc_shop_price = 10000;
    _shop_modifier.proc_shop_modifier_kind = shop_modifier_kind;
    switch (shop_modifier_kind)
    {
        case 0:
            _shop_modifier.proc_shop_label = "SPEED +2.5% - 10000 PTS";
            break;
        case 1:
            _shop_modifier.proc_shop_label = "SCORE +10% - 10000 PTS";
            break;
        case 2:
            _shop_modifier.proc_shop_label = "MAX ENERGY +50 - 10000 PTS";
            break;
        case 3:
            _shop_modifier.proc_shop_label = "MISSILE CAPACITY +5 - 10000 PTS";
            break;
        case 4:
            _shop_modifier.proc_shop_label = "UPGRADE CHANCE +1% - 10000 PTS";
            break;
        case 5:
            _shop_modifier.proc_shop_label = "MORE METROIDS - 10000 PTS";
            break;
        case 6:
            _shop_modifier.proc_shop_label = "REGENERATION +1 - 10000 PTS";
            break;
    }
    ds_list_add(shop_item_ids, _shop_modifier);
}
left_slot = -1;
main_slot = 0;
branch_slot = -1;
left_floor_y = 928;
main_floor_y = 928;
branch_floor_y = 640;
if (global.proc_depth > 0)
{
    left_slot = 0;
    if (global.proc_current_entry_kind == 1)
    {
        left_floor_y = 640;
    }
}
if (shop_active)
{
    left_floor_y = 928;
    main_floor_y = 928;
    branch_floor_y = 928;
}
has_branch = !shop_active && proc_has_branch(global.proc_seed, global.proc_room_index, global.proc_depth);
if (has_branch)
{
    branch_slot = 0;
}
branch_gate_kind = proc_branch_gate_kind(global.proc_seed, global.proc_room_index);
branch_gate_key = string(global.proc_room_index);
branch_gate_locked = has_branch && !ds_map_exists(global.proc_open_edges, branch_gate_key);
lock_required = !shop_active && !environment_active && (encounter_kind > 0 || (proc_stream_seed(global.proc_seed, 601, global.proc_room_index) % 4) != 0);
lock_active = lock_required && enemy_count > 0 && !ds_map_exists(global.proc_open_locks, string(global.proc_room_index));
lock_timer = 0;
lock_timeout_steps = room_speed * 210;
lock_block_count = 0;
if (lock_active)
{
    lock_block_count = proc_lock_build(lock_ids, left_slot, left_floor_y, main_slot, main_floor_y);
    if (has_branch)
    {
        lock_block_count += proc_lock_build(lock_ids, -1, 0, branch_slot, branch_floor_y);
    }
}
if (branch_gate_locked)
{
    proc_lock_build(branch_gate_ids, -1, 0, branch_slot, branch_floor_y);
}
if (branch_gate_locked && branch_gate_kind == 1 && global.maxmissiles > 0 && global.missiles <= 0)
{
    global.missiles = 1;
}
proc_door_visual_build(door_visual_ids, left_slot, left_floor_y, main_slot, main_floor_y, -1, -1, branch_slot, branch_floor_y, global.proc_room_index);
if (global.proc_entry_side == 2)
{
    spawn_x = 1216;
    spawn_y = branch_floor_y;
}
else if (global.proc_entry_side == 1)
{
    spawn_x = 1216;
    spawn_y = main_floor_y;
}
else
{
    spawn_x = 64;
    spawn_y = left_floor_y;
}
global.targetx = spawn_x;
global.targety = spawn_y;
global.camstartx = clamp(spawn_x, 160, 1120);
global.camstarty = clamp(spawn_y - 16, 120, 840);
global.transitionx = global.targetx;
global.transitiony = global.targety;
var _palette = proc_stream_seed(global.proc_seed, 401, global.proc_room_index);
background_color = make_color_rgb(5 + (_palette % 14), 10 + ((_palette div 17) % 18), 18 + ((_palette div 53) % 24));
_palette = proc_rng_next(_palette);
solid_color = make_color_rgb(48 + (_palette % 60), 72 + ((_palette div 19) % 70), 80 + ((_palette div 61) % 70));
solid_highlight = merge_color(solid_color, c_white, 0.25);
if (shop_active)
{
    background_color = make_color_rgb(8, 12, 30);
    solid_color = make_color_rgb(35, 70, 105);
    solid_highlight = make_color_rgb(90, 190, 240);
}
if (environment_active)
{
    background_color = make_color_rgb(28, 5, 3);
    solid_color = make_color_rgb(90, 35, 22);
    solid_highlight = make_color_rgb(255, 110, 45);
}
spawn_pending = 1;
transition_lock = 30;
