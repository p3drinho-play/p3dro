myid = global.clientID;
image_speed = 0.25;
alarm[0] = 60;
alarm[1] = 30;
sfx_play(128);
special = 0;
if (instance_exists(oClient))
{
    if (ds_list_size(oClient.roomListData) > 0)
    {
        var size = 1024;
        var type = 1;
        var alignment = 1;
        pbombBuffer = buffer_create(size, type, alignment);
        buffer_seek(pbombBuffer, buffer_seek_start, 0);
        buffer_write(pbombBuffer, buffer_u8, 24);
        buffer_write(pbombBuffer, buffer_u8, global.clientID);
        buffer_write(pbombBuffer, buffer_s16, x);
        buffer_write(pbombBuffer, buffer_s16, y);
        buffer_write(pbombBuffer, buffer_u8, global.sax);
        var bufferSize = buffer_tell(pbombBuffer);
        buffer_seek(pbombBuffer, buffer_seek_start, 0);
        buffer_write(pbombBuffer, buffer_s32, bufferSize);
        buffer_write(pbombBuffer, buffer_u8, 24);
        buffer_write(pbombBuffer, buffer_u8, global.clientID);
        buffer_write(pbombBuffer, buffer_s16, x);
        buffer_write(pbombBuffer, buffer_s16, y);
        buffer_write(pbombBuffer, buffer_u8, global.sax);
        var result = network_send_packet(oClient.socket, pbombBuffer, buffer_tell(pbombBuffer));
        buffer_delete(pbombBuffer);
    }
}
