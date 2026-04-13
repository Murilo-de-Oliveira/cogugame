/// @description Insert description here
// You can write your code in this editor

ui_state = UI_BATTLE_MENU_STATE.BUSY;

layout = {
	margin_x: display_get_gui_width() * 0.5,
	margin_y : display_get_gui_height(),
    menu_width : display_get_gui_width(),
    item_height : 28
};

rectangle_layout_normal = {
	x1: display_get_gui_width() * 0.55,
	x2: display_get_gui_width(),
	item_heigth: 48,
	color: c_grey
}

rectangle_layout_selected = {
	x1: display_get_width() * 0.75,
	x2: display_get_width() * 0.95,
	item_heigth: 64,
	color: c_grey
}

skill_layout = {
	x1: display_get_gui_width() * 0.1,
	x2: display_get_gui_width() * 0.4,
	item_height: 48,
	color: c_black,
	bg_color: c_white 
}

function draw_skill(_skill, _index, _color){
	draw_set_font(fnt_ui_main);
	draw_set_colour(skill_layout.bg_color);
	draw_rectangle(skill_layout.x1, (64 * _index) + 120, skill_layout.x2, (64 * _index) + 120 + skill_layout.item_height, false);
	draw_text_colour(skill_layout.x1 + 16, (64 * _index) + 120, _skill.name, _color, _color, _color, _color, 1);
	draw_text_colour(skill_layout.x2 - 96, (64 * _index) + 120, string(_skill.mp) + " mp", _color, _color, _color, _color, 1);
	//draw_text_colour(skill_layout.x1, (64 * _index) + 120, "texto", c_black, c_black, c_black, c_black, 1);
}

main_menu = ["Atacar", "Habilidade", "Defender", "Mover", "Item", "Fugir"];
main_selected = 0;

skill_list = [];
skill_selected = 0;

targets = [];
target_selected = [];

hover_target = noone;

action = -1;

item_padding = 32;

is_player_turn = false;

x_scale = 0;
y_scale = 0;

sen = 0;
offset = 0;

function convert_to_gui(){
	x_scale = display_get_gui_width() / room_width;
	y_scale = display_get_gui_height() / room_height;
}