/// @description Setup
//scr_create_grid();
instance_create_layer(32, 32, "Instances", obj_grid);
instance_create_layer(0, 0, "Instances", obj_cursor);
show_debug_message("Cursor criado");

// Dados da batalha
player_party_instances = [];
enemy_party_instances = [];
turn_queue = [];
background_sprite = noone;

// Dados de controle de estados
state = BATTLE_STATE.SETUP;
current_combatant = noone;
chosen_action = noone;
chosen_targets = noone;
chosen_item = noone;

function get_valid_targets(_action){
	//alterar para cada tipo de skill depois
	return enemy_party_instances;
}