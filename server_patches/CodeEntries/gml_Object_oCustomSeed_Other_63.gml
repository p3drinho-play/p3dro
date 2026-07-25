var ID = ds_map_find_value(async_load, "id");
if (ID == msg)
{
    if (ds_map_find_value(async_load, "status"))
    {
        var input = ds_map_find_value(async_load, "value");
        if (is_real(input))
        {
            input = floor(abs(input));
            if (input > 2000000000)
            {
                input = input % 2000000000;
            }
            random_set_seed(input);
            global.seed = input;
            if (global.seed == 0)
            {
                scr_default_global_items();
            }
            else
            {
                switch (global.rando)
                {
                    case 0:
                        scr_randomizer();
                        break;
                    case 1:
                        scr_randomizer_pure();
                        break;
                    case 2:
                        scr_rand_split_powerups();
                        break;
                    case 3:
                        scr_randomizer_split_items();
                        break;
                }
                global.proc_seed = global.seed;
                ini_open(working_directory + "\settings.ini");
                ini_write_real("Seedtroid", "seed", global.proc_seed);
                ini_close();
                global.proc_room = 0;
                global.proc_depth = 0;
                global.proc_entry_kind = 0;
                global.proc_entry_side = 0;
                global.proc_revision += 1;
                ds_list_clear(global.proc_path);
                ds_list_clear(global.proc_path_kinds);
                ds_list_add(global.proc_path, 0);
                ds_list_add(global.proc_path_kinds, 0);
                if (ds_exists(global.proc_open_locks, ds_type_map))
                {
                    ds_map_destroy(global.proc_open_locks);
                }
                global.proc_open_locks = ds_map_create();
                if (ds_exists(global.proc_peer_rooms, ds_type_map))
                {
                    ds_map_destroy(global.proc_peer_rooms);
                }
                global.proc_peer_rooms = ds_map_create();
                if (ds_exists(global.proc_enemy_states, ds_type_map))
                {
                    ds_map_destroy(global.proc_enemy_states);
                }
                global.proc_enemy_states = ds_map_create();
                if (ds_exists(global.proc_enemy_room_owner, ds_type_map))
                {
                    ds_map_destroy(global.proc_enemy_room_owner);
                }
                global.proc_enemy_room_owner = ds_map_create();
                oServer.alarm[10] = 30;
                with (oServer)
                {
                    proc_server_send_state(-1);
                }
            }
        }
    }
}
