var _list = argument0;
var _left_slot = argument1;
var _left_floor_y = argument2;
var _right_slot = argument3;
var _right_floor_y = argument4;
var _count = 0;
if (_left_slot >= 0)
{
    var _left_block = instance_create(16, _left_floor_y - 64, oSolid1);
    _left_block.image_yscale = 4;
    ds_list_add(_list, _left_block);
    _count += 1;
}
if (_right_slot >= 0)
{
    var _right_block = instance_create(1248, _right_floor_y - 64, oSolid1);
    _right_block.image_yscale = 4;
    ds_list_add(_list, _right_block);
    _count += 1;
}
return _count;
