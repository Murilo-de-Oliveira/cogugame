//if(global.GameManager.game_status == GameStatus.COMBAT){
if (true) {
	switch(state) {
	    case BATTLE_STATE.SETUP:
	        scr_battle_controller_setup();
	        break;
        
	    case BATTLE_STATE.START_TURN:
	        scr_battle_controller_start_turn();
	        break;
        
	    case BATTLE_STATE.PLAYER_INPUT:
	        //scr_battle_controller_player_input();
	        break; // Fim do case PLAYER_INPUT
		
		case BATTLE_STATE.TARGET_ENEMY:
			//scr_battle_controller_target_enemy();
			break;
		
		case BATTLE_STATE.TARGET_ALLY:
			//scr_battle_controller_target_ally();
			break;
		
		case BATTLE_STATE.ENEMY_DECISION:
			//scr_battle_controller_enemy_decision();
			break;
        
		case BATTLE_STATE.RESOLVE_ACTION:
			//scr_battle_controller_resolve_action();
			break;
		
		case BATTLE_STATE.VICTORY:
			//scr_battle_controller_player_won();
			//if (keyboard_check_pressed(vk_enter)) {
		    //    // Ex: room_goto(rm_mapa);
		    //}
			break;
		
		case BATTLE_STATE.NOTHING:
			//scr_state_nothing();
			break;
	}
}