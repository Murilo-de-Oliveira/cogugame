/// @description Insert description here
// You can write your code in this editor

//DEIXAR ESSA LÓGICA MELHOR, PORQUE ELA NÃO ARMAZENA O ESTADO ANTERIOR
//Um script ou outro objeto deveria controlar essa interação
if (keyboard_check_pressed(vk_escape)){
	if (previous_state != GameStatus.MENU){
		previous_state = GameStatus.MENU;
		global.GameManager.game_status = GameStatus.MENU; 
	}
	else {
		previous_state = GameStatus.COMBAT;
		global.GameManager.game_status = GameStatus.COMBAT;
	}
}

if (global.GameManager.game_status == GameStatus.MENU){
	switch(ui_menu_state){
		case UI_GAME_MENU_STATE.IDLE:
			var _vertical_input = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
            if (_vertical_input != 0) {
                selected_option = (selected_option + _vertical_input + array_length(menu_list)) % array_length(menu_list);
            }
		
			ui_menu_display.children = [];
			for(var _i = 0; _i < array_length(menu_list); _i++){
				var _color = (_i == selected_option) ? c_yellow : c_white;
				var _text = (_i == selected_option) ? "> " + menu_list[_i] : menu_list[_i];
				var _text_option = new UI_Text(0, 0, _text, fnt_ui_main, _color);
				ui_menu_display.add_child(_text_option);
			}
			ui_menu_display.update();
			break;
	}
}