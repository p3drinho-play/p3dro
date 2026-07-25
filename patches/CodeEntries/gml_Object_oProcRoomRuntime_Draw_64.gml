draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(global.fontMenuSmall);
draw_set_color(c_black);
draw_text(9, 9, "SEEDTROID  SEED " + string(global.proc_seed) + "  ROOM " + string(global.proc_depth + 1));
draw_set_color(c_white);
draw_text(8, 8, "SEEDTROID  SEED " + string(global.proc_seed) + "  ROOM " + string(global.proc_depth + 1));
draw_set_alpha(0.82);
draw_set_color(c_black);
draw_rectangle(344, 2, 540, 58, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(255, 220, 80));
draw_text_transformed(354, 5, "SCORE " + string(floor(global.proc_score)), 2.4, 2.4, 0);
draw_set_color(make_color_rgb(110, 220, 255));
draw_text_transformed(354, 31, "COMBO " + string(global.proc_combo_count) + "  x" + string_format(global.proc_combo_mult, 1, 2), 1.7, 1.7, 0);
proc_map_draw(548, 34, 8);
if (shop_active)
{
    draw_set_halign(fa_center);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(110, 220, 255));
    draw_text(160, 48, "FEDERATION SHOP - TOUCH AN ITEM TO BUY");
    if (shop_message_timer > 0)
    {
        draw_set_color(make_color_rgb(255, 220, 80));
        draw_text(160, 70, shop_message);
    }
    draw_set_halign(fa_left);
}
if (lock_active)
{
    draw_set_color(make_color_rgb(255, 80, 48));
    draw_text_transformed(360, 64, "LOCKDOWN - KILLS LEFT " + string(lock_kills_remaining), 1.8, 1.8, 0);
}
else if (branch_gate_locked)
{
    draw_set_color(make_color_rgb(110, 220, 255));
    draw_text(8, 24, "OPTIONAL BRANCH: " + proc_gate_name(branch_gate_kind) + " GATE");
}
else
{
    draw_set_color(c_white);
    if (environment_active)
    {
        draw_set_color(make_color_rgb(255, 100, 40));
        draw_text_transformed(8, 24, "RISING LAVA - MOVE!", 2, 2, 0);
    }
    else if (encounter_kind == 2)
    {
        draw_text(8, 24, "BOSS ROOM");
    }
    else if (encounter_kind == 1)
    {
        draw_text(8, 24, "METROID ENCOUNTER");
    }
    else
    {
        draw_text(8, 24, "MAIN ROUTE OPEN");
    }
}
draw_set_color(c_white);
draw_text(8, 222, "F9: NEXT SEED");
draw_set_alpha(1);
