frz = instance_create(x, y, oEnemyFrozen);
frz.image_xscale = facing;
frz.sprite_index = frozenspr;
frz.image_index = image_index;
frz.mask_index = frozenspr;
frz.image_angle = image_angle;
frz.xSprite = sprite_index;
frz.xLastFrame = image_index;
frz.xLastFacing = image_xscale;
frz.xLastAngle = image_angle;
frz.xLastDepth = depth;
frz.xLastXPos = xstart;
frz.xLastYPos = ystart;
frz.xLastEnemy = object_index;
frz.canbeX = canbeX;
frz.timer = timer;
frz.rotspeed = rotspeed;
frz.myspeed = myspeed;
frz.offset = offset;
frz.moveratio = moveratio;
frz.movesteps = movesteps;
if (object_index == oHalzyn)
{
    frz.xLastGlow = glow;
}
if (platform_engine_active == 1)
{
    frz.xVel = xVel;
    frz.yVel = yVel;
    frz.collisionBoundsOffsetLeftX = collisionBoundsOffsetLeftX - 2;
    frz.collisionBoundsOffsetTopY = collisionBoundsOffsetTopY - 2;
    frz.collisionBoundsOffsetRightX = collisionBoundsOffsetRightX - 2;
    frz.collisionBoundsOffsetBottomY = collisionBoundsOffsetBottomY - 2;
}
else
{
    frz.xVel = hspeed;
    frz.yVel = vspeed;
}
frz.depth = 10;
frz.falling = freezefall;
frz.proc_generated = proc_generated;
frz.proc_room_key = proc_room_key;
frz.proc_spawn_index = proc_spawn_index;
frz.proc_death_sent = proc_death_sent;
frz.proc_last_hit_client = proc_last_hit_client;
frz.proc_elite = proc_elite;
PlaySoundMono(82);
instance_destroy();
