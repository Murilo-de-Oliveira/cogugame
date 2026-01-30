switch(ui_state){
	case UI_BATTLE_MENU_STATE.MAIN_MENU:
		ui_step_main();
		break;
		
	case UI_BATTLE_MENU_STATE.SKILL_MENU:
        ui_step_skills();
        break;

    case UI_BATTLE_MENU_STATE.TARGET_SELECT:
        ui_step_target();
        break;
}

function ui_step_main(){
	
	if (keyboard_check_pressed(vk_down)) main_selected++;
	if (keyboard_check_pressed(vk_up)) main_selected--;
	
	main_selected = clamp(main_selected, 0, array_length(main_menu) - 1);
	
	if (keyboard_check_pressed(vk_enter)) {
		switch (main_selected) {
			case ACTION_TYPE.ATTACK:
				prepare_targeting(ACTION_TYPE.ATTACK);
				break;
			
			case ACTION_TYPE.SKILL:
				skill_list = obj_battle_controller.current_combatant.skills;
				ui_state = UI_BATTLE_MENU_STATE.SKILL_MENU;
				main_selected = 0;
				break;
		}
	}
}

function ui_step_skills(){
	
	if (keyboard_check_pressed(vk_down)) skill_selected++;
	if (keyboard_check_pressed(vk_up)) skill_selected--;
	
	skill_selected = clamp(skill_selected, 0, array_length(skill_list) - 1);
	
	if (keyboard_check_pressed(vk_escape)){
		ui_state = UI_BATTLE_MENU_STATE.MAIN_MENU;
		skill_selected = 0;
		return;
	}
	
	if (keyboard_check_pressed(vk_enter)){
		prepare_targeting(ACTION_TYPE.SKILL);
		skill_selected = 0;
	}
}

function ui_step_target(){
	
	if (keyboard_check_pressed(vk_right)) target_selected++;
    if (keyboard_check_pressed(vk_left)) target_selected--;
	
	target_selected = clamp(target_selected, 0, array_length(targets)-1);
	
	convert_to_gui();
	
	if (keyboard_check_pressed(vk_escape)) {
        ui_state = UI_BATTLE_MENU_STATE.MAIN_MENU;
        return;
    }
	
	if (keyboard_check_pressed(vk_enter)) {
		confirm_action();
	}
}

function prepare_targeting(_action) {
	
	//separar em tipo de skill (single target, todos, aliados, etc)
	targets = obj_battle_controller.get_valid_targets(_action);
	target_selected = 0;
	
	obj_battle_controller.chosen_action = _action;
	ui_state = UI_BATTLE_MENU_STATE.TARGET_SELECT;
}

function confirm_action() {
	var target = targets[target_selected];
	
	obj_battle_controller.commit_action(
		chosen_action,
		ui_state == UI_BATTLE_MENU_STATE.SKILL_MENU ? skill_list[skill_select] : undefined,
		target
	);
	
	ui_state = UI_BATTLE_MENU_STATE.BUSY;
}