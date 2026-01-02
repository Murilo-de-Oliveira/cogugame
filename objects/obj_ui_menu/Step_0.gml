/// @description Insert description here
// You can write your code in this editor

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

//selected_option = -1;

for(var i = 0; i < array_length(battle_options); i++){
	var _y1 = pos_y + (i * gap_in_items);
	var _y2 = _y1 + gap_in_items;
	
	var _x1 = pos_x;
	var _x2 = pos_x + 128;
	
	if (_mx > _x1 && _mx < _x2 && _my > _y1 && _my < _y2) {
        selected_option = i;
		if (mouse_check_button_pressed(mb_left)) {
			current_ui_menu = UI_BATTLE_MENU_STATE.SKILLS;
			skill_list = obj_battle_controller.current_combatant.skills;
			current_combatant_icon = obj_battle_controller.current_combatant.sprites[$ "idle"];
		}
    }
}

if (keyboard_check_pressed(vk_escape)) {
	current_ui_menu = UI_BATTLE_MENU_STATE.MAIN;
}