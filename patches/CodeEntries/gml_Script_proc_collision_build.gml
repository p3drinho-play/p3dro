var _grid = argument0;
var _count = 0;
for (var _y = 0; _y < 60; _y++)
{
    for (var _x = 0; _x < 80; _x++)
    {
        if (ds_grid_get(_grid, _x, _y) == 1)
        {
            instance_create(_x * 16, _y * 16, oSolid1);
            _count += 1;
        }
    }
}
return _count;
