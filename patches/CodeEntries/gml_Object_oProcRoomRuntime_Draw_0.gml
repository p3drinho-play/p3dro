draw_set_alpha(1);
draw_set_color(background_color);
draw_rectangle(0, 0, room_width - 1, room_height - 1, false);
var _stripe_state = proc_stream_seed(global.proc_seed, 401, global.proc_room_index);
for (var _stripe = 0; _stripe < 18; _stripe++)
{
    _stripe_state = proc_rng_next(_stripe_state);
    var _stripe_x = 32 + (_stripe_state % 1216);
    _stripe_state = proc_rng_next(_stripe_state);
    var _stripe_h = 48 + (_stripe_state % 176);
    draw_set_color(merge_color(background_color, solid_color, 0.18));
    draw_triangle(_stripe_x - 24, 0, _stripe_x + 24, 0, _stripe_x, _stripe_h, 0);
}
if (environment_active && global.waterlevel < room_height)
{
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(230, 45, 5));
    draw_rectangle(0, global.waterlevel, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(255, 210, 35));
    draw_rectangle(0, global.waterlevel, room_width, global.waterlevel + 5, false);
}
for (var _y = 0; _y < tiles_h; _y++)
{
    for (var _x = 0; _x < tiles_w; _x++)
    {
        if (ds_grid_get(solid_grid, _x, _y) == 1)
        {
            var _px = _x * tile_size;
            var _py = _y * tile_size;
            draw_set_color(solid_color);
            draw_rectangle(_px, _py, _px + 15, _py + 15, false);
            draw_set_color(solid_highlight);
            draw_rectangle(_px, _py, _px + 15, _py + 2, false);
        }
    }
}
draw_set_color(c_white);
draw_set_alpha(1);
if (shop_active)
{
    draw_set_font(global.fontMenuSmall);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    for (var _sign_i = 0; _sign_i < ds_list_size(shop_item_ids); _sign_i += 1)
    {
        var _sign_item = ds_list_find_value(shop_item_ids, _sign_i);
        if (instance_exists(_sign_item))
        {
            var _sign_x = _sign_item.x;
            var _sign_top = _sign_item.y - 168;
            var _sign_left = _sign_x - 80;
            var _sign_right = _sign_x + 80;
            var _sign_bottom = _sign_item.y - 58;
            var _sign_title = "";
            var _sign_effect = "";
            var _sign_effect_scale = 2;
            switch (_sign_item.proc_shop_kind)
            {
                case 1:
                    _sign_title = "MISSILES +5";
                    break;
                case 2:
                    _sign_title = "SUPER +2";
                    break;
                case 3:
                    _sign_title = "E-TANK";
                    break;
                case 4:
                    _sign_title = "P-BOMBS +2";
                    break;
                case 5:
                    _sign_title = "MODIFIER";
                    switch (_sign_item.proc_shop_modifier_kind)
                    {
                        case 0:
                            _sign_effect = "SPEED +2.5%";
                            break;
                        case 1:
                            _sign_effect = "SCORE +10%";
                            break;
                        case 2:
                            _sign_effect = "MAX ENERGY +50";
                            _sign_effect_scale = 1.7;
                            break;
                        case 3:
                            _sign_effect = "MISSILE CAPACITY +5";
                            _sign_effect_scale = 1.35;
                            break;
                        case 4:
                            _sign_effect = "UPGRADE CHANCE +1%";
                            _sign_effect_scale = 1.4;
                            break;
                        case 5:
                            _sign_effect = "MORE METROIDS";
                            _sign_effect_scale = 1.7;
                            break;
                        default:
                            _sign_effect = "REGENERATION +1";
                            _sign_effect_scale = 1.55;
                            break;
                    }
                    break;
            }
            draw_set_alpha(0.94);
            draw_set_color(make_color_rgb(4, 10, 22));
            draw_rectangle(_sign_left, _sign_top, _sign_right, _sign_bottom, false);
            draw_set_alpha(1);
            if (global.proc_score >= _sign_item.proc_shop_price)
            {
                draw_set_color(make_color_rgb(80, 255, 130));
            }
            else
            {
                draw_set_color(make_color_rgb(255, 80, 70));
            }
            draw_rectangle(_sign_left, _sign_top, _sign_right, _sign_bottom, true);
            draw_rectangle(_sign_left + 3, _sign_top + 3, _sign_right - 3, _sign_bottom - 3, true);
            if (_sign_item.proc_shop_kind == 5)
            {
                draw_text_transformed(_sign_x, _sign_top + 10, _sign_title, 2.8, 2.8, 0);
                draw_set_color(c_white);
                draw_text_transformed(_sign_x, _sign_top + 39, _sign_effect, _sign_effect_scale, _sign_effect_scale, 0);
            }
            else
            {
                draw_text_transformed(_sign_x, _sign_top + 15, _sign_title, 3, 3, 0);
            }
            draw_set_color(make_color_rgb(255, 220, 80));
            draw_text_transformed(_sign_x, _sign_top + 68, string(_sign_item.proc_shop_price) + " PTS", 3.5, 3.5, 0);
        }
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
draw_set_color(c_white);
draw_set_alpha(1);
