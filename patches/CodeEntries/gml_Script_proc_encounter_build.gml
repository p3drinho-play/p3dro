var _grid = argument0;
var _seed = argument1;
var _room_id = argument2;
var _depth = argument3;
var _ids = argument4;
var _kind = argument5;
if (_depth >= 45 && (_depth % 45) == 0)
{
    var _boss_cycle = ((_depth div 45) - 1) % 4;
    var _boss = -4;
    switch (_boss_cycle)
    {
        case 0:
            _boss = instance_create(640, 480, oEris);
            break;
        case 1:
            _boss = instance_create(640, 896, oTorizo);
            break;
        case 2:
            _boss = instance_create(640, 896, oTorizo);
            break;
        case 3:
            _boss = instance_create(640, 896, oTorizo);
            break;
    }
    if (instance_exists(_boss))
    {
        _boss.proc_generated = 1;
        _boss.proc_room_key = global.proc_room_key;
        _boss.proc_spawn_index = 0;
        ds_list_add(_ids, _boss);
        return 1;
    }
    return 0;
}
if (_kind == 1)
{
    if (global.maxmissiles > 0 && global.missiles < 5)
    {
        global.missiles = 5;
    }
    var _temp_ids = ds_list_create();
    proc_enemy_build(_grid, _seed, _room_id, _temp_ids);
    var _spawn_x = 320;
    var _spawn_y = 176;
    var _found_spawn = 0;
    var _temp_count = ds_list_size(_temp_ids);
    if (_temp_count > 0)
    {
        var _spawn_enemy = ds_list_find_value(_temp_ids, 0);
        if (instance_exists(_spawn_enemy))
        {
            _spawn_x = _spawn_enemy.x;
            _spawn_y = _spawn_enemy.y;
            _found_spawn = 1;
        }
    }
    var _i = _temp_count - 1;
    while (_i >= 0)
    {
        var _enemy = ds_list_find_value(_temp_ids, _i);
        if (instance_exists(_enemy))
        {
            with (_enemy)
            {
                instance_destroy();
            }
        }
        _i -= 1;
    }
    ds_list_destroy(_temp_ids);
    if (!_found_spawn)
    {
        return 0;
    }
    var _alpha_id = 1 + (_room_id % 98);
    global.metdead[_alpha_id] = 0;
    var _metroid = -4;
    if (_depth >= 125)
    {
        _metroid = create_gamma(_spawn_x, _spawn_y, 12, choose(-1, 1));
    }
    else
    {
        _metroid = instance_create(_spawn_x, _spawn_y, oMAlpha);
    }
    if (instance_exists(_metroid))
    {
        if (_depth >= 125)
        {
            _metroid.myid = _alpha_id;
            _metroid.proc_generated = 1;
            _metroid.proc_room_key = global.proc_room_key;
            _metroid.proc_spawn_index = 0;
            _metroid.proc_last_hit_client = -1;
        }
        else
        {
            with (_metroid)
            {
                set_monster_vars(0);
                myid = _alpha_id;
                spriteset = 0;
                shell = -4;
                facing = choose(-1, 1);
                visible = true;
                image_alpha = 1;
                image_blend = c_white;
                image_speed = 0.2;
                myspr = sprite_index;
                proc_generated = 1;
                proc_room_key = global.proc_room_key;
                proc_spawn_index = 0;
                proc_last_hit_client = -1;
            }
        }
        ds_list_add(_ids, _metroid);
        return 1;
    }
    return 0;
}
var _ids_before = ds_list_size(_ids);
var _normal_count = proc_enemy_build(_grid, _seed, _room_id, _ids);
if (global.ibeam)
{
    var _monster_amount = 5 + (proc_stream_seed(_seed, 1201, _room_id) % 11);
    _monster_amount = min(_monster_amount, _normal_count);
    for (var _monster_number = 0; _monster_number < _monster_amount; _monster_number += 1)
    {
        var _monster_x = 320;
        var _monster_y = 176;
        var _monster_spawn_index = _monster_number;
        var _replace_index = _ids_before;
        var _replaced_enemy = ds_list_find_value(_ids, _replace_index);
        if (instance_exists(_replaced_enemy))
        {
            _monster_x = _replaced_enemy.x;
            _monster_y = _replaced_enemy.y;
            _monster_spawn_index = _replaced_enemy.proc_spawn_index;
            with (_replaced_enemy)
            {
                instance_destroy();
            }
        }
        ds_list_delete(_ids, _replace_index);
        var _monster = instance_create(_monster_x, _monster_y, oMonster);
        if (instance_exists(_monster))
        {
            _monster.myid = -1;
            _monster.proc_generated = 1;
            _monster.proc_room_key = global.proc_room_key;
            _monster.proc_spawn_index = _monster_spawn_index;
            _monster.dontfollow = 0;
            _monster.targetx = _monster_x;
            _monster.targety = _monster_y;
            ds_list_add(_ids, _monster);
        }
        else
        {
            _normal_count -= 1;
        }
    }
}
return _normal_count;
