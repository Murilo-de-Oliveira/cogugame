/// @description Insert description here
// You can write your code in this editor

//Variáveis de config
enum UI_GAME_MENU_STATE{
	IDLE,
	CONTINUE,
	PARTY,
	CHARACTERS,
	INVENTORY,
	QUIT
}

previous_state = global.GameManager.game_status;
ui_menu_state = UI_GAME_MENU_STATE.IDLE;

ui_menu_display = new UI_Panel(room_width/4, room_height/4, (3 * room_width)/4, (3 * room_height)/4, "vertical");

menu_list = ["Continuar", "Equipe", "Personagens", "Inventário", "Sair"];
selected_option = 0;

//Informações externas
party = global.GameManager.current_party;