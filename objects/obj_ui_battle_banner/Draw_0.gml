/// @description Insert description here
// You can write your code in this editor

var screen_w = display_get_gui_width();
var screen_h = display_get_gui_height();

draw_set_alpha(alpha);
draw_set_font(font_banner);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
    screen_w / 2,
    screen_h / 4,
    text
);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1);
scr_reset_alignment();
