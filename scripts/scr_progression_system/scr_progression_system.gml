// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function scr_perform_level_up(_character){
	var _character_info = _character.character_info;
	var _combat_info = _character.combat_info;
	
	show_debug_message(variable_struct_get_names(global.PlayableCharacters[_character.template_id]));
	var _growth_rates = global.PlayableCharacters[_character.template_id].stat_growth;
	
	_character_info.xp -= _character_info.xp_to_next_level;
	_character_info.level++;
	
	_combat_info.hp_max += _growth_rates.hp_max;
    _combat_info.mp_max += _growth_rates.mp_max;
    _combat_info.attributes_base.strength += _growth_rates.strength;
    _combat_info.attributes_base.dexterity += _growth_rates.dexterity;
	//fazer para o resto
	
	//recalcular os stats aqui
	
	_character_info.xp_to_nect_level = scr_get_xp_for_level(_character_info.level);
	
	show_debug_message("LEVEL UP! " + _character_info.name + " agora é nível " + string(_character_info.level));
}

function scr_grant_xp_to_party(_xp_amount){
	//iterar pela party ativa
	
	for(var _i = 0; _i < array_length(player_party_instances); _i++){
		var _battle_clone = player_party_instances[_i];
		
		if (_battle_clone.combat_info.is_dead) continue;
		
		show_debug_message(_battle_clone.character_info.name + " ganhou " + string(_xp_amount) + " XP.");
		_battle_clone.character_info.xp += _xp_amount;
		
		//personagem pode subir de nível várias vezes
		while (_battle_clone.character_info.xp >= _battle_clone.character_info.xp_to_next_level){
			scr_perform_level_up(_battle_clone);
		}
	}
}