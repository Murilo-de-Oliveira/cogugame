/// @description Insert description here
// You can write your code in this editor

ui_state = UI_BATTLE_MENU_STATE.MAIN_MENU;

layout = {
	margin_x: display_get_gui_width() * 0.05,
	margin_y : display_get_gui_height() * 0.7,
    menu_width : 180,
    item_height : 28
};

main_menu = ["Atacar", "Habilidade", "Defender", "Mover", "Item", "Fugir"];
main_selected = 0;

skill_list = [];
skill_selected = 0;

targets = [];
target_selected = [];

hover_target = noone;

x_scale = 0;
y_scale = 0;

function convert_to_gui(){
	x_scale = display_get_gui_width() / room_width;
	y_scale = display_get_gui_height() / room_height;
}