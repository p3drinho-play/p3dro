if (oControl.widescreen)
{
    if ((oControl.widescreen_space + 320) <= room_width)
    {
        x = clamp(x, limit, room_width - limit);
    }
    else
    {
        x = floor(room_width / 2);
    }
}
if (global.proc_active)
{
    var _proc_camera_half_width = 160 + floor(oControl.widescreen_space / 2);
    x = clamp(x, _proc_camera_half_width, room_width - _proc_camera_half_width);
    y = clamp(y, 120, room_height - 120);
}
