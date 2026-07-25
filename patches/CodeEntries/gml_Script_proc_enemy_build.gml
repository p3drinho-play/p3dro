var _grid = argument0;
var _seed = argument1;
var _room_index = argument2;
var _enemy_ids = argument3;
var _state = proc_stream_seed(_seed, 501, _room_index);
var _wanted = 6 + (_state % 50);
var _spawned = 0;
var _attempt = 0;
var _reserved = ds_grid_create(80, 60);
ds_grid_clear(_reserved, 0);
while (_spawned < _wanted && _attempt < 4096)
{
    _attempt += 1;
    _state = proc_rng_next(_state);
    var _cell_x = 4 + (_state % 72);
    _state = proc_rng_next(_state);
    var _cell_y = 6 + (_state % 47);
    _state = proc_rng_next(_state);
    var _enemy_type = _state % 36;
    var _needs_support = 0;
    switch (_enemy_type)
    {
        case 0:
        case 1:
        case 3:
        case 5:
        case 7:
        case 11:
        case 15:
        case 17:
        case 18:
        case 20:
        case 21:
        case 25:
        case 29:
        case 30:
        case 32:
            _needs_support = 1;
            break;
    }
    var _valid = ds_grid_get(_reserved, _cell_x, _cell_y) == 0;
    var _spawn_x = (_cell_x * 16) + 8;
    var _spawn_y = _cell_y * 16;
    if (_valid && _needs_support)
    {
        _valid = ds_grid_get(_grid, _cell_x, _cell_y) == 1 && ds_grid_get(_grid, _cell_x, _cell_y - 1) == 0 && ds_grid_get(_grid, _cell_x, _cell_y - 2) == 0 && ds_grid_get(_grid, _cell_x, _cell_y - 3) == 0 && (ds_grid_get(_grid, _cell_x - 1, _cell_y) == 1 || ds_grid_get(_grid, _cell_x + 1, _cell_y) == 1);
    }
    else if (_valid)
    {
        _spawn_y += 8;
        var _check_y = _cell_y - 1;
        while (_check_y <= (_cell_y + 1))
        {
            var _check_x = _cell_x - 1;
            while (_check_x <= (_cell_x + 1))
            {
                if (ds_grid_get(_grid, _check_x, _check_y) != 0)
                {
                    _valid = 0;
                }
                _check_x++;
            }
            _check_y++;
        }
    }
    if (_valid)
    {
        var _enemy = -4;
        switch (_enemy_type)
        {
            case 0:
                _enemy = instance_create(_spawn_x, _spawn_y, oAutoad);
                break;
            case 1:
                _enemy = instance_create(_spawn_x, _spawn_y, oAutom);
                break;
            case 2:
                _enemy = instance_create(_spawn_x, _spawn_y, oAutrack);
                break;
            case 3:
                _enemy = instance_create(_spawn_x, _spawn_y, oBladeBot);
                break;
            case 4:
                _enemy = instance_create(_spawn_x, _spawn_y, oBlobAir);
                break;
            case 5:
                _enemy = instance_create(_spawn_x, _spawn_y, oBlobThrowerLand);
                break;
            case 6:
                _enemy = instance_create(_spawn_x, _spawn_y, oCavedropper);
                break;
            case 7:
                _enemy = instance_create(_spawn_x, _spawn_y, oChuteLeech);
                break;
            case 8:
                _enemy = instance_create(_spawn_x, _spawn_y, oDrivel);
                break;
            case 9:
                _enemy = instance_create(_spawn_x, _spawn_y, oGawron);
                break;
            case 10:
                _enemy = instance_create(_spawn_x, _spawn_y, oGlowFly);
                break;
            case 11:
                _enemy = instance_create(_spawn_x, _spawn_y, oGravitt);
                break;
            case 12:
                _enemy = instance_create(_spawn_x, _spawn_y, oGullugg);
                break;
            case 13:
                _enemy = instance_create(_spawn_x, _spawn_y, oGunzoo);
                break;
            case 14:
                _enemy = instance_create(_spawn_x, _spawn_y, oHalzyn);
                break;
            case 15:
                _enemy = instance_create(_spawn_x, _spawn_y, oHornoad);
                break;
            case 16:
                _enemy = instance_create(_spawn_x, _spawn_y, oMeboid);
                break;
            case 17:
                _enemy = instance_create(_spawn_x, _spawn_y, oMoheek);
                break;
            case 18:
                _enemy = instance_create(_spawn_x, _spawn_y, oMoto);
                break;
            case 19:
                _enemy = instance_create(_spawn_x, _spawn_y, oMumbo);
                break;
            case 20:
                _enemy = instance_create(_spawn_x, _spawn_y, oNeedler);
                break;
            case 21:
                _enemy = instance_create(_spawn_x, _spawn_y, oOctroll);
                break;
            case 22:
                _enemy = instance_create(_spawn_x, _spawn_y, oPincherFly);
                break;
            case 23:
                _enemy = instance_create(_spawn_x, _spawn_y, oRamulken);
                break;
            case 24:
                _enemy = instance_create(_spawn_x, _spawn_y, oRoboMine);
                break;
            case 25:
                _enemy = instance_create(_spawn_x, _spawn_y, oSeerook);
                break;
            case 26:
                _enemy = instance_create(_spawn_x, _spawn_y, oSenjoo);
                break;
            case 27:
                _enemy = instance_create(_spawn_x, _spawn_y, oShielder);
                break;
            case 28:
                _enemy = instance_create(_spawn_x, _spawn_y, oShirk);
                break;
            case 29:
                _enemy = instance_create(_spawn_x, _spawn_y, oSkorp);
                break;
            case 30:
                _enemy = instance_create(_spawn_x, _spawn_y, oSkreek);
                break;
            case 31:
                _enemy = instance_create(_spawn_x, _spawn_y, oTPO);
                break;
            case 32:
                _enemy = instance_create(_spawn_x, _spawn_y, oTsumuri);
                break;
            case 33:
                _enemy = instance_create(_spawn_x, _spawn_y, oWallfire);
                break;
            case 34:
                _enemy = instance_create(_spawn_x, _spawn_y, oYumbo);
                break;
            case 35:
                _enemy = instance_create(_spawn_x, _spawn_y, oYumee);
                break;
        }
        if (instance_exists(_enemy))
        {
            _enemy.proc_generated = 1;
            _enemy.proc_room_key = global.proc_room_key;
            _enemy.proc_spawn_index = _spawned;
            _enemy.proc_enemy_type = _enemy_type;
            _enemy.proc_death_sent = 0;
            _enemy.proc_last_hit_client = -1;
            _enemy.hitbeam = 1;
            _enemy.hitmissile = 1;
            _enemy.hitmissileexpl = 1;
            _enemy.hitbomb = 1;
            _enemy.hitpbomb = 1;
            _enemy.hitscrewattack = 1;
            _enemy.hitpseudoscrew = 1;
            _enemy.myhealth = min(_enemy.myhealth, 60);
            _enemy.damage = min(_enemy.damage, 20);
            var _rare_roll = proc_stream_seed(_seed, 1301, (_room_index * 100) + _spawned) % 10;
            if (_rare_roll == 0)
            {
                _enemy.myhealth = ceil(_enemy.myhealth * 2.2);
                _enemy.image_blend = make_color_rgb(255, 170, 80);
                _enemy.proc_elite = 1;
            }
            else
            {
                _enemy.proc_elite = 0;
            }
            _state = proc_rng_next(_state);
            if ((_state % 2) == 0)
            {
                _enemy.facing = -1;
            }
            else
            {
                _enemy.facing = 1;
            }
            if (_enemy_type == 26)
            {
                _enemy.offset = 24 + (_state % 9);
                _enemy.movesteps = 25 + (_state % 11);
                _enemy.moveratio = 4 + (_state % 2);
                _enemy.targetnum = 1;
                _enemy.targetposx[0] = _enemy.x;
                _enemy.targetposy[0] = _enemy.y;
                _enemy.targetposx[1] = _enemy.x - (_enemy.offset * _enemy.facing);
                _enemy.targetposy[1] = _enemy.y - _enemy.offset;
                _enemy.targetposx[2] = _enemy.x;
                _enemy.targetposy[2] = _enemy.y - (_enemy.offset * 2);
                _enemy.targetposx[3] = _enemy.x + (_enemy.offset * _enemy.facing);
                _enemy.targetposy[3] = _enemy.y - _enemy.offset;
            }
            _state = proc_rng_next(_state);
            _enemy.timer = 30 + (_state % 180);
            _enemy.image_angle = 0;
            ds_list_add(_enemy_ids, _enemy);
            var _reserve_y = max(0, _cell_y - 1);
            while (_reserve_y <= min(59, _cell_y + 1))
            {
                var _reserve_x = max(0, _cell_x - 1);
                while (_reserve_x <= min(79, _cell_x + 1))
                {
                    ds_grid_set(_reserved, _reserve_x, _reserve_y, 1);
                    _reserve_x++;
                }
                _reserve_y++;
            }
            _spawned += 1;
        }
    }
}
ds_grid_destroy(_reserved);
return _spawned;
