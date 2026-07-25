if (!global.proc_active || room == rm_transition || !instance_exists(oCharacter))
{
    return 0;
}
var _return_room = global.proc_return_room;
global.proc_active = 0;
global.proc_room_key = -1;
global.targetx = global.proc_return_x;
global.targety = global.proc_return_y;
global.camstartx = global.proc_return_cam_x;
global.camstarty = global.proc_return_cam_y;
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
popup_text_ext("SEEDTROID: RETURNING TO CAMPAIGN", 240);
room_change(_return_room, 1);
Mute_Loops();
StopAmbLoops();
return 1;
