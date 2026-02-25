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
chosen_skill = noone;

global.spawn_order = 0;

function get_valid_targets(_action){
	//alterar para cada tipo de skill depois
	return enemy_party_instances;
}

function commit_action(chosen_action, target){	
	show_debug_message(ACTION_TYPE.SKILL == chosen_action);
	if chosen_action == ACTION_TYPE.ATTACK{
		
		var _attack = current_combatant.stats.strength;
		target.hurt(_attack.get_total());
	}
	
	if chosen_action == ACTION_TYPE.SKILL{
		var _skill = chosen_skill;
		var _attribute = current_combatant.stats.intelligence;
		var _mod = _attribute.get_total();
		show_debug_message("Attribute: " + string(_attribute));
		show_debug_message("Modificador: " + string(_mod));
		target.hurt(_skill.m_power + _mod);
		var _effect = apply_debuff(_skill.debuff);
		array_push(_effect);
	}
}