/// @description Setup
instance_create_layer(32, 32, "Instances", obj_grid);

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

enemy_list_vanguard = [];
enemy_list_rearguard = [];
enemy_list_side = [];

global.spawn_order = 0;

global.EFFECT_DATA = [];

global.EFFECT_DATA[EffectType.STUN] = {
	name: "Atordoamento",
	description: "O personagem não pode realizar ações no próximo turno",
	icon: spr_icon_stun,
	base_turns: 1,
};

global.EFFECT_DATA[EffectType.BURN] = {
	name: "Queimadura",
	description: "O personagem sofre dano ao fim do turno",
	icon: spr_burn_icon,
	base_turns: 3,
}

function get_valid_targets_skill(){
	var target_type = chosen_skill.target_type;
	
	switch(target_type){
		case TargetType.SINGLE_ENEMY or TargetType.ALL_ENEMIES:
			return enemy_party_instances;
		case TargetType.VANGUARD_ENEMY:
			return enemy_list_vanguard;
		case TargetType.REARGUARD_ENEMY:
			return enemy_list_rearguard;
		case TargetType.SIDE_ENEMY:
			return enemy_list_side;
	}
}

function get_valid_targets(_action){
	//alterar para cada tipo de skill depois
	switch(_action){
		case ACTION_TYPE.ATTACK:
			return enemy_party_instances;
		case ACTION_TYPE.SKILL:
			return get_valid_targets_skill();
	}
}

function receive_player_action(_action_type, _skill_or_item, _targets){
	show_debug_message("Ação recebida");
	
	chosen_action = _action_type;
	chosen_skill = _skill_or_item;
	chosen_targets = _targets;
	
	obj_ui_combat_menu.ui_state = UI_BATTLE_MENU_STATE.BUSY;
	obj_ui_combat_menu.is_player_turn = false;

	state = BATTLE_STATE.RESOLVE_ACTION;
}

function commit_action(chosen_action, target){	
	show_debug_message(ACTION_TYPE.SKILL == chosen_action);
	if chosen_action == ACTION_TYPE.ATTACK{
		var _attack = new BasicAttack();
		_attack.execute(current_combatant, chosen_targets);
	}
	
	else if chosen_action == ACTION_TYPE.SKILL{
		chosen_skill.execute(current_combatant, chosen_targets);
	}
	
	else if (chosen_action == ACTION_TYPE.ITEM){
		//criar um chosen_item.execute(current_combatant, chosen_targets);
	}
}