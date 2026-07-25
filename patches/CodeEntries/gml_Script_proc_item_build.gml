var _seed = argument0;
var _room_id = argument1;
var _depth = argument2;
var _item = -4;
var _item_id = -1;
var _repeatable = 0;
switch (_depth)
{
    case 0:
        _item_id = 52;
        _item = instance_create(320, 416, oItemM_52);
        break;
    case 1:
        _item_id = 0;
        _item = instance_create(320, 416, oItemBomb);
        break;
    case 2:
        if (global.saxmode)
        {
            _item_id = 53;
            _item = instance_create(320, 416, oItemM_52);
        }
        else
        {
            _item_id = 11;
            _item = instance_create(320, 416, oItemIBeam);
        }
        break;
    case 3:
        _item_id = 2;
        _item = instance_create(320, 416, oItemSpiderBall);
        break;
    case 4:
        _item_id = 3;
        _item = instance_create(320, 416, oItemJumpBall);
        break;
    case 5:
        _item_id = 4;
        _item = instance_create(320, 416, oItemHijump);
        break;
    case 6:
        _item_id = 10;
        _item = instance_create(320, 416, oItemCBeam);
        break;
    case 7:
        _item_id = 12;
        _item = instance_create(320, 416, oItemWBeam);
        break;
    case 8:
        _item_id = 5;
        _item = instance_create(320, 416, oItemVaria);
        break;
    case 9:
        _item_id = 6;
        _item = instance_create(320, 416, oItemSpaceJump);
        break;
    case 10:
        _item_id = 7;
        _item = instance_create(320, 416, oItemSpeedBooster);
        break;
    case 11:
        _item_id = 13;
        _item = instance_create(320, 416, oItemSBeam);
        break;
    case 12:
        _item_id = 14;
        _item = instance_create(320, 416, oItemPBeam);
        break;
    case 13:
        _item_id = 8;
        _item = instance_create(320, 416, oItemScrewAttack);
        break;
    case 14:
        _item_id = 9;
        _item = instance_create(320, 416, oItemGravity);
        break;
}
var _major_chance = 100;
if (_depth >= 5)
{
    _major_chance = min(25, 3 + global.proc_item_bonus);
}
var _is_major = 0;
if (_item_id >= 0 && _item_id <= 14)
{
    _is_major = 1;
}
if (_is_major == 1 && instance_exists(_item))
{
    var _major_roll = proc_stream_seed(_seed, 903 + _item_id, _room_id) % 100;
    if (_major_roll >= _major_chance)
    {
        with (_item)
        {
            instance_destroy();
        }
        _repeatable = 1;
        var _fallback_roll = proc_stream_seed(_seed, 904 + _item_id, _room_id) % 100;
        if (_fallback_roll < 70)
        {
            _item_id = 50;
            _item = instance_create(320, 416, oItemETank_50);
        }
        else
        {
            _item_id = 52 + (_room_id % 9);
            _item = instance_create(320, 416, oItemM_52);
        }
    }
}
if (_depth > 14 && (proc_stream_seed(_seed, 901, _room_id) % 2) == 0)
{
    _repeatable = 1;
    var _repeatable_roll = proc_stream_seed(_seed, 902, _room_id) % 100;
    if (_repeatable_roll < 70)
    {
        _item_id = 50;
        _item = instance_create(320, 416, oItemETank_50);
    }
    else
    {
        _item_id = 52 + (_room_id % 9);
        _item = instance_create(320, 416, oItemM_52);
    }
}
if (instance_exists(_item))
{
    var _item_state = proc_stream_seed(_seed, 903, _room_id);
    var _item_start = _item_state % 3888;
    var _item_attempt = 0;
    var _item_placed = 0;
    while (_item_attempt < 3888 && !_item_placed)
    {
        var _item_cell = (_item_start + _item_attempt) % 3888;
        var _item_x = 4 + (_item_cell % 72);
        var _item_y = 3 + ((_item_cell div 72) % 54);
        if (ds_grid_get(solid_grid, _item_x, _item_y) == 1 && ds_grid_get(solid_grid, _item_x, _item_y - 1) == 0 && ds_grid_get(solid_grid, _item_x, _item_y - 2) == 0)
        {
            _item.x = (_item_x * 16) + 8;
            _item.y = _item_y * 16;
            _item_placed = 1;
        }
        _item_attempt += 1;
    }
    if (!_repeatable && _item_id >= 0 && global.item[_item_id] == 1)
    {
        with (_item)
        {
            instance_destroy();
        }
        return 0;
    }
    _item.itemid = _item_id;
    _item.proc_generated = 1;
    return 1;
}
return 0;
