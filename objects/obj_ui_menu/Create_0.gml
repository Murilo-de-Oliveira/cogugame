/// @description Insert description here
// You can write your code in this editor

height = display_get_gui_height();
width = display_get_gui_width();

menu_height = height * 0.7;

current_combatant_icon = noone;

current_ui_menu = UI_BATTLE_MENU_STATE.MAIN;
battle_options = ["Atacar", "Habilidade", "Defender", "Mover", "Item", "Fugir"];
selected_option = 0;

skill_list = [];
skill_menu_selected = 0;

pos_x = width * 0.2;
pos_y = height * 0.7;
gap_in_items = 32;