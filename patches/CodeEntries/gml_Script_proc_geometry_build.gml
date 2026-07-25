var _grid = argument0;
var _seed = argument1;
var _room_id = argument2;
var _width = 80;
var _height = 60;
var _has_branch = proc_has_branch(_seed, _room_id, global.proc_depth);
var _structure_roll = proc_stream_seed(_seed, 303, _room_id) % 100;
layout_kind = -1;
if (_structure_roll < 20)
{
    layout_kind = proc_stream_seed(_seed, 302, _room_id) % 6;
}
ds_grid_clear(_grid, 0);
for (var _x = 0; _x < _width; _x++)
{
    ds_grid_set(_grid, _x, 0, 1);
    ds_grid_set(_grid, _x, 1, 1);
    ds_grid_set(_grid, _x, 58, 1);
    ds_grid_set(_grid, _x, 59, 1);
}
for (var _y = 0; _y < _height; _y++)
{
    ds_grid_set(_grid, 0, _y, 1);
    ds_grid_set(_grid, 1, _y, 1);
    ds_grid_set(_grid, 78, _y, 1);
    ds_grid_set(_grid, 79, _y, 1);
}
switch (layout_kind)
{
    case 0:
        for (var _tx = 16; _tx <= 63; _tx++)
        {
            var _tdistance = abs(_tx - 39);
            var _theight = max(1, 13 - ceil(_tdistance / 2));
            var _ttop = 58 - _theight;
            for (var _ty = _ttop; _ty < 58; _ty++)
            {
                ds_grid_set(_grid, _tx, _ty, 1);
            }
        }
        break;
    case 1:
        for (var _hx = 10; _hx <= 34; _hx++)
        {
            var _hd = abs(_hx - 22);
            var _hh = max(1, 9 - ceil(_hd / 2));
            var _hy = 58 - _hh;
            while (_hy < 58)
            {
                ds_grid_set(_grid, _hx, _hy, 1);
                _hy++;
            }
        }
        for (var _hx2 = 45; _hx2 <= 69; _hx2++)
        {
            var _hd2 = abs(_hx2 - 57);
            var _hh2 = max(1, 9 - ceil(_hd2 / 2));
            var _hy2 = 58 - _hh2;
            while (_hy2 < 58)
            {
                ds_grid_set(_grid, _hx2, _hy2, 1);
                _hy2++;
            }
        }
        break;
    case 2:
        for (var _cx = 2; _cx <= 29; _cx++)
        {
            var _ch = max(1, 15 - floor((_cx - 2) / 2));
            var _cy = 58 - _ch;
            while (_cy < 58)
            {
                ds_grid_set(_grid, _cx, _cy, 1);
                _cy++;
            }
        }
        for (var _cx2 = 50; _cx2 <= 77; _cx2++)
        {
            var _ch2 = max(1, 15 - floor((77 - _cx2) / 2));
            var _cy2 = 58 - _ch2;
            while (_cy2 < 58)
            {
                ds_grid_set(_grid, _cx2, _cy2, 1);
                _cy2++;
            }
        }
        break;
    case 3:
        for (var _wx = 6; _wx <= 73; _wx++)
        {
            var _wave = _wx % 20;
            if (_wave > 10)
            {
                _wave = 20 - _wave;
            }
            var _wh = 2 + floor(_wave / 2);
            var _wy = 58 - _wh;
            while (_wy < 58)
            {
                ds_grid_set(_grid, _wx, _wy, 1);
                _wy++;
            }
        }
        break;
    case 4:
        for (var _rx = 12; _rx <= 22; _rx++)
        {
            var _rtop = 56 - (_rx - 12);
            var _ry = _rtop + 1;
            while (_ry < 58)
            {
                ds_grid_set(_grid, _rx, _ry, 1);
                _ry++;
            }
            instance_create(_rx * 16, _rtop * 16, oSlope1Normal);
        }
        for (var _rx2 = 57; _rx2 <= 67; _rx2++)
        {
            var _rtop2 = 46 + (_rx2 - 57);
            var _ry2 = _rtop2 + 1;
            while (_ry2 < 58)
            {
                ds_grid_set(_grid, _rx2, _ry2, 1);
                _ry2++;
            }
            instance_create(_rx2 * 16, _rtop2 * 16, oSlope2Normal);
        }
        break;
    case 5:
        for (var _ax = 24; _ax <= 55; _ax++)
        {
            for (var _ay = 55; _ay < 58; _ay++)
            {
                ds_grid_set(_grid, _ax, _ay, 1);
            }
        }
        break;
}
if (global.proc_depth > 0)
{
    var _left_floor = 58;
    if (global.proc_current_entry_kind == 1)
    {
        _left_floor = 40;
        for (var _lsx = 0; _lsx <= 22; _lsx++)
        {
            var _lstop = 40 + floor(_lsx / 3);
            for (var _lsy = _lstop; _lsy < 58; _lsy++)
            {
                ds_grid_set(_grid, _lsx, _lsy, 1);
            }
        }
    }
    var _left_y = _left_floor - 4;
    while (_left_y < _left_floor)
    {
        ds_grid_set(_grid, 0, _left_y, 0);
        ds_grid_set(_grid, 1, _left_y, 0);
        _left_y++;
    }
}
for (var _main_y = 54; _main_y < 58; _main_y++)
{
    ds_grid_set(_grid, 78, _main_y, 0);
    ds_grid_set(_grid, 79, _main_y, 0);
}
if (_has_branch)
{
    for (var _bsx = 57; _bsx < 80; _bsx++)
    {
        var _bstop = 57 - floor(((_bsx - 57) * 17) / 22);
        for (var _bsy = _bstop; _bsy < 58; _bsy++)
        {
            ds_grid_set(_grid, _bsx, _bsy, 1);
        }
    }
    for (var _branch_y = 36; _branch_y < 40; _branch_y++)
    {
        ds_grid_set(_grid, 78, _branch_y, 0);
        ds_grid_set(_grid, 79, _branch_y, 0);
    }
}
for (var _shaft_y = 2; _shaft_y < 58; _shaft_y++)
{
    for (var _shaft_x = 23; _shaft_x <= 56; _shaft_x++)
    {
        ds_grid_set(_grid, _shaft_x, _shaft_y, 0);
    }
}
for (var _main_y2 = 54; _main_y2 < 58; _main_y2++)
{
    ds_grid_set(_grid, 78, _main_y2, 0);
    ds_grid_set(_grid, 79, _main_y2, 0);
}
for (var _safe_y = 44; _safe_y < 58; _safe_y++)
{
    for (var _safe_left_x = 2; _safe_left_x <= 77; _safe_left_x++)
    {
        ds_grid_set(_grid, _safe_left_x, _safe_y, 0);
    }
}
for (var _safe_floor_x = 2; _safe_floor_x <= 77; _safe_floor_x++)
{
    ds_grid_set(_grid, _safe_floor_x, 58, 1);
}
if (global.proc_depth > 0 && global.proc_current_entry_kind == 1)
{
    for (var _safe_left_y2 = 28; _safe_left_y2 < 40; _safe_left_y2++)
    {
        for (var _safe_left_x2 = 2; _safe_left_x2 <= 34; _safe_left_x2++)
        {
            ds_grid_set(_grid, _safe_left_x2, _safe_left_y2, 0);
        }
    }
    for (var _safe_left_floor = 2; _safe_left_floor <= 34; _safe_left_floor++)
    {
        ds_grid_set(_grid, _safe_left_floor, 40, 1);
    }
}
if (_has_branch)
{
    for (var _safe_branch_y = 28; _safe_branch_y < 40; _safe_branch_y++)
    {
        for (var _safe_branch_x = 45; _safe_branch_x <= 77; _safe_branch_x++)
        {
            ds_grid_set(_grid, _safe_branch_x, _safe_branch_y, 0);
        }
    }
    for (var _safe_branch_floor = 45; _safe_branch_floor <= 77; _safe_branch_floor++)
    {
        ds_grid_set(_grid, _safe_branch_floor, 40, 1);
    }
}
for (var _center_step = 0; _center_step < 18; _center_step++)
{
    var _center_y = 56 - (_center_step * 3);
    var _center_x = 26;
    if ((_center_step % 2) == 1)
    {
        _center_x = 39;
    }
    for (var _center_tile = 0; _center_tile < 16; _center_tile++)
    {
        ds_grid_set(_grid, _center_x + _center_tile, _center_y, 1);
    }
}
if (layout_kind == -1)
{
    var _platform_state = proc_stream_seed(_seed, 1801, _room_id);
    for (var _platform_number = 0; _platform_number < 18; _platform_number += 1)
    {
        _platform_state = proc_rng_next(_platform_state);
        var _platform_x = 4 + (_platform_state % 12);
        if ((_platform_number % 2) == 1)
        {
            _platform_x = 60 + (_platform_state % 11);
        }
        _platform_state = proc_rng_next(_platform_state);
        var _platform_y = 6 + (_platform_state % 29);
        _platform_state = proc_rng_next(_platform_state);
        var _platform_width = 4 + (_platform_state % 7);
        for (var _platform_tile = 0; _platform_tile < _platform_width; _platform_tile += 1)
        {
            ds_grid_set(_grid, min(76, _platform_x + _platform_tile), _platform_y, 1);
        }
    }
}
if (global.proc_depth > 0 && (global.proc_depth % 25) != 0 && (global.proc_depth % 45) != 0)
{
    if (layout_kind == 1 || layout_kind == 2 || layout_kind == 3)
    {
        var _spike_state = proc_stream_seed(_seed, 1701, _room_id);
        for (var _cluster = 0; _cluster < 3; _cluster++)
        {
            _spike_state = proc_rng_next(_spike_state);
            var _spike_center = 15 + (_spike_state % 6);
            if ((_cluster % 2) == 1)
            {
                _spike_center = 59 + (_spike_state % 6);
            }
            var _surface_y = 2;
            while (_surface_y < 58 && ds_grid_get(_grid, _spike_center, _surface_y) == 0)
            {
                _surface_y += 1;
            }
            for (var _spike_row = 0; _spike_row < 3; _spike_row++)
            {
                var _spike_count = 5 - (_spike_row * 2);
                var _spike_start = _spike_center - floor(_spike_count / 2);
                for (var _spike_i = 0; _spike_i < _spike_count; _spike_i++)
                {
                    var _spike_instance = instance_create((_spike_start + _spike_i) * 16, (_surface_y * 16) - 16 - (_spike_row * 14), oSpikes1);
                    if (instance_exists(_spike_instance))
                    {
                        _spike_instance.visible = true;
                        _spike_instance.image_index = 0;
                        _spike_instance.image_speed = 0;
                    }
                }
            }
        }
    }
}
return 1;
