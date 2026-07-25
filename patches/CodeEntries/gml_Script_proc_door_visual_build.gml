var _ids = argument0;
var _left_slot = argument1;
var _left_floor = argument2;
var _main_slot = argument3;
var _main_floor = argument4;
var _left_edge = argument5;
var _main_edge = argument6;
var _branch_slot = argument7;
var _branch_floor = argument8;
var _branch_edge = argument9;
var _controller = id;
if (_left_slot >= 0)
{
    var _left = instance_create(24, _left_floor - 64, oProcDoorVisual);
    _left.controller = _controller;
    _left.side = -1;
    _left.edge_index = _left_edge;
    _left.image_xscale = 1;
    ds_list_add(_ids, _left);
}
if (_main_slot >= 0)
{
    var _main = instance_create(1256, _main_floor - 64, oProcDoorVisual);
    _main.controller = _controller;
    _main.side = 1;
    _main.edge_index = _main_edge;
    _main.image_xscale = -1;
    ds_list_add(_ids, _main);
}
if (_branch_slot >= 0)
{
    var _branch = instance_create(1256, _branch_floor - 64, oProcDoorVisual);
    _branch.controller = _controller;
    _branch.side = 2;
    _branch.edge_index = _branch_edge;
    _branch.image_xscale = -1;
    ds_list_add(_ids, _branch);
}
return ds_list_size(_ids);
