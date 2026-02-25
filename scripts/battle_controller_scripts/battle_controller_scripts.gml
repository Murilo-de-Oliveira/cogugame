function _debug_timer(){
	return string(current_time/1000) + "ms";
}

function _sort_turn_queue(){
	array_sort(turn_queue, function(char1, char2){
		if(char1.stats.dexterity.get_total() > char2.stats.dexterity.get_total()) return -1;
		if(char1.stats.dexterity.get_total() < char2.stats.dexterity.get_total()) return 1;
		
		if(char1.order > char2.order) return -1;
		if(char1.order < char2.order) return 1;
		
		return 0;
	});
}

function _rotate_turn_queue(){
	var previous_char = array_shift(turn_queue);
	array_push(turn_queue, previous_char);
}

function scr_battle_controller_setup(){
	show_debug_message("Setup iniciado " + _debug_timer());
	
	eric = instance_create_layer(0, 0, "Characters", obj_hero);
	ugu = instance_create_layer(0, 0, "Characters", obj_hero);
	goblin1 = instance_create_layer(0, 0, "Characters", obj_enemy);
	goblin2 = instance_create_layer(0, 0, "Characters", obj_enemy);
	eric.create_character(
		Characters.ERIC,
		"Eric",
		{ "idle": spr_eric , "icon": spr_char_icon_base},
	    {
	      max_hp: 100,
	      max_mp: 100,
		  hp: 100,
		  mp: 100,
	      strength: new Attribute(10),
	      dexterity: new Attribute(10),
	      constitution: new Attribute(10),
	      intelligence: new Attribute(10),
	      faith: new Attribute(10),
	      lucky: new Attribute(10)
	    },
	    {
	      physical: 1.0,
	      magic: 1.0,
	      fire: 1.0,
	      ice: 1.0,
	      lightning: 1.0,
	      dark: 1.0,
	      divine: 1.0
	    },
		[
			new Skill("Bola de Fogo", 1, 20, 60, 80, Element.FIRE, Debuffs.BURN, TargetType.ENEMY, "Atira uma bola de fogo no inimigo"),
			new Skill("Sopro Gélido", 1, 10, 30, 80, Element.ICE, Debuffs.NONE, TargetType.ENEMY, "Sopra ar gelado no inimigo")
		],
		3,
		1
	);
	ugu.create_character(
		Characters.UGU,
		"Ugu",
		{ "idle": spr_eric , "icon": spr_char_icon_base},
	    {
	      max_hp: 100,
	      max_mp: 100,
		  hp: 100,
		  mp: 100,
	      strength: new Attribute(10),
	      dexterity: new Attribute(10),
	      constitution: new Attribute(10),
	      intelligence: new Attribute(10),
	      faith: new Attribute(10),
	      lucky: new Attribute(10)
	    },
	    {
	      physical: 1.0,
	      magic: 1.0,
	      fire: 1.0,
	      ice: 1.0,
	      lightning: 1.0,
	      dark: 1.0,
	      divine: 1.0
	    },
		[
			new Skill("Bola de Fogo", 1, 20, 60, 80, Element.FIRE, Debuffs.BURN, TargetType.ENEMY, "Atira uma bola de fogo no inimigo"),
			new Skill("Sopro Gélido", 1, 10, 30, 80, Element.ICE, Debuffs.NONE, TargetType.ENEMY, "Sopra ar gelado no inimigo")
		],
		2,
		1
	);

	goblin1.create_character(
		Characters.UGU,
		"Goblin",
		{ "idle": spr_hero_dummy , "icon": spr_char_icon_base},
	    {
	      max_hp: 100,
	      max_mp: 100,
		  hp: 100,
		  mp: 100,
	      strength: new Attribute(10),
	      dexterity: new Attribute(0),
	      constitution: new Attribute(10),
	      intelligence: new Attribute(10),
	      faith: new Attribute(10),
	      lucky: new Attribute(10)
	    },
	    {
	      physical: 1.0,
	      magic: 1.0,
	      fire: 1.0,
	      ice: 1.0,
	      lightning: 1.0,
	      dark: 1.0,
	      divine: 1.0
	    },
		[],
		6,
		1
	);
	
	goblin2.create_character(
		Characters.UGU,
		"Goblin",
		{ "idle": spr_hero_dummy , "icon": spr_char_icon_base},
	    {
	      max_hp: 100,
	      max_mp: 100,
		  hp: 100,
		  mp: 100,
	      strength: new Attribute(10),
	      dexterity: new Attribute(0),
	      constitution: new Attribute(10),
	      intelligence: new Attribute(10),
	      faith: new Attribute(10),
	      lucky: new Attribute(10)
	    },
	    {
	      physical: 1.0,
	      magic: 1.0,
	      fire: 1.0,
	      ice: 1.0,
	      lightning: 1.0,
	      dark: 1.0,
	      divine: 1.0
	    },
		[],
		6,
		2
	);
	
	eric.order = global.spawn_order++;
	ugu.order = global.spawn_order++;
	goblin1.order = global.spawn_order++;
	goblin2.order = global.spawn_order++;
	
	player_party_instances = [eric, ugu];
	enemy_party_instances = [goblin1, goblin2];
	
	var _player_side_columns = 5;
	var _enemy_side_columns = 5;
	
	for (var _i = 0; _i < array_length(player_party_instances); _i++){
		var _character = player_party_instances[_i];
		var _desired_position = [_character.grid_x, _character.grid_y];
		
		scr_set_occupant(_desired_position[0], _desired_position[1], _character);
		show_debug_message(_character.name + " adicionado ao grid");
	}
	
	for (var _i = 0; _i < array_length(enemy_party_instances); _i++){
		var _enemy = enemy_party_instances[_i];
		var _desired_position = [_enemy.grid_x, _enemy.grid_y];
		
		scr_set_occupant(_desired_position[0], _desired_position[1], _enemy);
	}
	
	turn_queue = array_concat(player_party_instances, enemy_party_instances);
	_sort_turn_queue();
	for(var i = 0; i < array_length(turn_queue); i++){
		show_debug_message(turn_queue[i].name);
	}

	//if !instance_exists(obj_cursor){
	//	instance_create_layer(0, 0, "Instances", obj_cursor);
	//	show_debug_message("Cursor criado");
	//}
	
	if !instance_exists(obj_ui_battle_banner){
		instance_create_layer(
			display_get_gui_width()/2,
			display_get_gui_height()/4, 
			"UI_battle_banner", 
			obj_ui_battle_banner
		);
	}
	
	if (!instance_exists(obj_ui_menu)) {
		instance_create_layer(0, 0, "Instances", obj_ui_menu);
	}
	
	show_debug_message("Setup finalizado " + _debug_timer());
	
	state = BATTLE_STATE.START_TURN;
}

function scr_battle_controller_start_turn(){
	current_combatant = array_first(turn_queue);
	
	show_debug_message("--- Início do turno de " + current_combatant.name +  " ---" + _debug_timer());
	
	//obj_cursor.update_position(current_combatant);
	obj_cursor.is_visible = true;
	
	if (current_combatant.is_dead) {
        show_debug_message(current_combatant.name + " está fora de combate. Pulando turno.");
        scr_battle_controller_end_turn(); // Simplesmente encerra o turno dele
        return;
    }
	
	if current_combatant.is_defending {
		current_combatant.is_defending = false;
	}

	if (current_combatant.char_type == "Hero"){
		state = BATTLE_STATE.PLAYER_INPUT;
	}
	else{
		//state = BATTLE_STATE.ENEMY_DECISION;
		state = BATTLE_STATE.NOTHING;
	}
}

function scr_battle_controller_player_input(){
	obj_ui_menu.is_player_turn = true;
	
	obj_ui_menu.current_combatant_icon = current_combatant.sprites[$ "idle"];
	
	if obj_ui_menu.ui_state == UI_BATTLE_MENU_STATE.BUSY{
		state = BATTLE_STATE.RESOLVE_ACTION;
		show_debug_message("Em estado de resolve action " + _debug_timer());
		obj_ui_menu.ui_state = UI_BATTLE_MENU_STATE.MAIN_MENU;
		obj_ui_menu.is_player_turn = false;
	}
}

function scr_battle_controller_enemy_decision(){
	var _enemy = current_combatant;
	var _ai = _enemy.combat_info.ai_profile;
	show_debug_message(_ai);
	
	var _possible_actions = [];
	
	// Itera sobre as prioridades de skill de maior para menor?
    for (var i = 0; i < array_length(_ai.skill_priorities); i++) {
        var priority = _ai.skill_priorities[i];
        
        // --- LÓGICA DE EXECUÇÃO ATUALIZADA ---
        var _condition_met = false;
		
        if ((priority.condition)) {
            // script_execute chama a função que está guardada em 'priority.condition'
            // e passa os argumentos necessários para ela.
            _condition_met = script_execute(
                priority.condition,                      // A função a ser chamada
                _enemy,                                  // Argumento _self
                enemy_party_instances,                   // Argumento _allies
                player_party_instances,                  // Argumento _enemies
                priority.condition_args                  // Argumento _args
            );
        }
        
        // Se a condição foi satisfeita...
        if (_condition_met) {
			show_debug_message("Condição satisfeita para " + string(priority));
            for (var j = 0; j < priority.weight; j++) {
                array_push(_possible_actions, priority.skill_id);
            }
        }
    }
	
	show_debug_message("Possible actions: " + string(_possible_actions));
	
	if (array_length(_possible_actions) > 0){
		var _action = _possible_actions[irandom(array_length(_possible_actions) - 1)];
		chosen_action = {
			data: global.SkillList[$ _action],
			type: "Skill"
		}
	}
	else{
		chosen_action = {
			data: global.SkillList.Defense,
			type: "Defense"
		}
	}
	
	if (chosen_action.data.typeTarget == "Enemy") {
        var _target = player_party_instances[irandom(array_length(player_party_instances) - 1)];
        chosen_targets = [_target]; // Lembra que chosen_targets é um array!
		show_debug_message(_enemy.character_info.name + " decidiu usar " + chosen_action.data.name + " em " + chosen_targets[0].character_info.name);
    } 
    else if (chosen_action.data.typeTarget == "Ally") {
        // Lógica para curar um aliado (ex: o aliado com menos vida)
        // Por enquanto, vamos curar a si mesmo
        chosen_targets = [_enemy];
		show_debug_message(_enemy.character_info.name + " decidiu usar " + chosen_action.data.name + " em " + chosen_targets[0].character_info.name);
    }
	else if (chosen_action.data.typeTarget == "Self"){
		chosen_targets = _enemy;
		show_debug_message(_enemy.character_info.name + " decidiu usar " + chosen_action.data.name + " em " + chosen_targets.character_info.name);
	}
    
    // --- 3. Avançar o Estado ---
    state = BATTLE_STATE.RESOLVE_ACTION;
}

function scr_battle_controller_resolve_action() {
    if (chosen_action == noone) {
        show_debug_message("ERRO: Tentativa de resolver uma ação vazia.");
        scr_battle_controller_end_turn();
        return;
    }
	
	show_debug_message("Ação será commitada");
	
	commit_action(
		chosen_action,
		chosen_targets
	);
	
	chosen_action = noone;
	chosen_targets = noone;
	selected_option = 0;
	skill_menu_selected = 0;
	can_move = true;
	state = BATTLE_STATE.END_TURN;

	//var _action_data = chosen_action.data;
	//
	//show_debug_message("Action data: " + string(_action_data));
	//var _is_single_target = false;
	//
	//if (struct_get(_action_data, "area_of_effect") != undefined){
	//	_is_single_target = (_action_data.area_of_effect == "SingleTarget");
	//}
	//
	//if (is_callable(_action_data.vfx_function)) {
	//    // Itera sobre todos os alvos da ação
	//    for (var i = 0; i < array_length(chosen_targets); i++) {
	//        var _target = chosen_targets[i];
    //        
	//        // Calcula a posição central do alvo em pixels
	//        var _vfx_x = (_target.combat_info.grid_x * 32) + 16;
	//        var _vfx_y = (_target.combat_info.grid_y * 32) + 16;
    //        
	//        // Chama a função de VFX na posição do alvo
	//		show_debug_message("Chama VFX");
	//        _action_data.vfx_function(_vfx_x, _vfx_y);
	//		show_debug_message("Executou VFX");
	//    }
	//}
	//	
	//// --- LÓGICA DE EXECUÇÃO UNIFICADA ---
    //if (chosen_action.type == "Item") {
    //    // Funções de item geralmente precisam de (usuário, alvo)
    //    var _target = _is_single_target ? chosen_targets[0] : chosen_targets;
    //    _action_data.effect(current_combatant, _target);
    //    
    //    // Remove o item do inventário após o uso
	//	show_debug_message("Preparando para remover item do inventário: " + string(chosen_action.data.name));
	//	show_debug_message("ID do item que será removido: " + string(scr_string_to_item_id(chosen_action.data.name)));
	//	show_debug_message(global.GameManager.inventory.remove(scr_string_to_item_id(chosen_action.data.name)));
    //    //global.GameManager.inventory.remove(scr_string_to_item_id(chosen_action.data.name)); // Ajuste aqui conforme sua implementação
    //} 
    //else { // "Skill" or "Defense", etc.
    //    // Funções de skill precisam de (caster, alvo(s), skill_data)
    //    var _targets = chosen_targets; // Passa o array completo ou um único alvo dependendo da skill
    //    if (_is_single_target) {
    //        _targets = chosen_targets[0];
    //    }
	//	show_debug_message("Action data: " + string(_action_data));
    //    _action_data.effect(current_combatant, _targets, _action_data);
	//	show_debug_message("Rodou o efeito da skill");
    //}
    //
    //// Limpa a ação e finaliza o turno
    //chosen_action = noone;
    //chosen_targets = noone;
	//selected_option = 0;
	//skill_menu_selected = 0;
	//can_move = true;
    //scr_battle_controller_end_turn();
}

/// @function scr_battle_controller_end_turn()
/// @description Processa o final do turno de um combatente.
function scr_battle_controller_end_turn() {
    show_debug_message("--- Fim do turno de " + current_combatant.name + " ---" + _debug_timer());
	
	if (array_length(current_combatant.debuff_list) > 0) {
		for(var i = 0; i < array_length(current_combatant.debuff_list); i++){
			var debuff = current_combatant.debuff_list[i];
			debuff.effect();
		}
	}
	
	// Verificação de Derrota (Game Over)
    var _heroes_alive = 0;
    for (var i = 0; i < array_length(player_party_instances); i++) {
        if (!player_party_instances[i].is_dead) {
            _heroes_alive++;
        }
    }
    
    if (_heroes_alive == 0) {
        show_debug_message("DERROTA! Todos os heróis caíram.");
        state = BATTLE_STATE.DEFEAT;
        // Aqui você pode adicionar uma função para a tela de derrota, como scr_show_defeat_screen()
        return; // A batalha acabou, não continua para o próximo turno.
    }

    // Verificação de Vitória
    var _enemies_alive = 0;
    for (var i = 0; i < array_length(enemy_party_instances); i++) {
        if (!enemy_party_instances[i].is_dead) {
            _enemies_alive++;
        }
    }

    if (_enemies_alive == 0) {
        show_debug_message("VITÓRIA! Todos os inimigos foram derrotados.");
        state = BATTLE_STATE.VICTORY;
        // A função scr_battle_controller_player_won() será chamada no próximo step.
        return; // A batalha acabou.
    }

    // Se ninguém ganhou ou perdeu, a batalha continua...
    // 3. Avança a fila de turnos
    //var _combatant_that_acted = array_shift(turn_queue);
    //array_push(turn_queue, _combatant_that_acted);
    
    // 4. Muda o estado para o início do próximo turno
    state = BATTLE_STATE.START_TURN;
	_rotate_turn_queue();
	show_debug_message("--- Iniciando novo turno... ---" + _debug_timer());
}

function scr_battle_controller_player_won(){
	// Cálculo dos valores de ouro e xp
	
	var _total_xp_reward = 0;
	var _total_gold_reward = 0;
	
	for(var _i = 0; _i < array_length(enemy_party_instances); _i++){
		var _enemy_dump = enemy_party_instances[_i];
		
		_total_xp_reward += _enemy_dump.xp_loot;
		_total_gold_reward += _enemy_dump.gold_loot; 
	}
	
	scr_grant_xp_to_party(_total_xp_reward);
	global.GameManager.gold += _total_gold_reward;
	
	scr_apply_battle_results();
	
	scr_show_victory_screen();
}

function scr_state_nothing(){
	show_debug_message("O combate acabou!");
}

//FUNÇÕES AUXILIARES

//function scr_find_free_cell_player_side(_type, _max_columns){
//	for (var _x = 0; _x < _max_columns; _x++){
//		for (var _y = 0; _y < ds_grid_height(global.grid); _y++){
//			var _cell = ds_grid_get(global.grid, _x, _y);
//			if (!_cell.occupied && _cell.cell_type == _type){
//				return [_x, _y];
//			}
//		}
//	}
//	return undefined;
//}

//function scr_find_free_cell_enemy_side(_type, _max_columns){
//	for (var _x = 9; _x > _max_columns; _x--){
//		for (var _y = 0; _y < ds_grid_height(global.grid); _y++){
//			var _cell = ds_grid_get(global.grid, _x, _y);
//			show_debug_message(_cell);
//			if (!_cell.occupied && _cell.cell_type == _type){
//				return [_x, _y];
//			}
//		}
//	}
//	return undefined;
//}


/**
 * Function Description
 * @param {int} _char_id Description
 * @return {Struct.PlayerCharacter | noone} Retorna a instância do personagem
 */
function create_character_instance(_char_id){
	var _template = global.PlayableCharacters[_char_id];
	if (!is_struct(_template)){
		show_error("Personagem com ID " + string(_char_id) + " não encontrado!", true);
        return noone;
	}
	
	//var _json = json_stringify(_template);
    //var _instance = json_parse(_json);
	
	var _instance = struct_deep_copy(_template);
	
	_instance.persistent_uid = "char_" + string(random(999));
	_instance.template_id = _char_id; //id do molde
	
	_instance.grid_x = -1; // Posição inicial fora do grid
    _instance.grid_y = -1;
    
    return _instance;
}

function create_enemy_instance(_enemy_id){
	var _template = global.Enemies[_enemy_id];
	if (!is_struct(_template)){
		show_error("Inimigo com ID " + string(_enemy_id) + " não encontrado!", true);
        return noone;
	}
	
	//var _json = json_stringify(_template);
    //var _instance = json_parse(_json);
	
	var _instance = struct_deep_copy(_template);
	
	_instance.persistent_uid = "char_" + string(random(999));
	_instance.template_id = _enemy_id; //id do molde
	
	_instance.grid_x = -1; // Posição inicial fora do grids
    _instance.grid_y = -1;
    
    return _instance;
}

/// @function scr_draw_battlefield();
/// @description Desenha o grid e os ocupantes na tela.
function scr_draw_battlefield() {

    // Defina o tamanho de cada célula em pixels
    var _cell_width = 32;
    var _cell_height = 32;

    // Percorre todo o grid
    for (var _x = 0; _x < ds_grid_width(global.grid); _x++) {
        for (var _y = 0; _y < ds_grid_height(global.grid); _y++) {
            var _cell = global.grid[# _x, _y];
            var _occupant = _cell.occupant;

            // Calcula a posição da célula em pixels na tela
            var _px = (_x * _cell_width) + 160;
            var _py = (_y * _cell_height) + 32;

            // Desenha uma borda para a célula (opcional, igual ao seu exemplo)
            draw_set_color(c_white);
            draw_rectangle(_px, _py, _px + _cell_width, _py + _cell_height, true);

            // Se houver um personagem (ocupante) na célula...
            if (_occupant != noone) {
                // Desenha ele!
                // Por enquanto, vamos desenhar um círculo para representar o personagem.
                // Depois trocamos pelo sprite.
                var _center_x = _px + _cell_width / 2;
                var _center_y = _py + _cell_height / 2;

                var _sprite = _occupant.sprites.idle;
                if (sprite_exists(_sprite)) {
                    draw_sprite(_sprite, 0, _center_x, _center_y);
                }
				else {
					var _color = _occupant.character_type == "Hero" ? c_green : c_red;
					draw_set_color(_color);
	                draw_circle(_center_x, _center_y, _cell_width / 2 - 4, false);
				}
				
				var _effects = _occupant.combat_info.status_effects;
		        var _icon_offset_x = 0; // Para alinhar múltiplos ícones

		        for (var i = 0; i < array_length(_effects); i++) {
		            var _icon = _effects[i].icon;

		            if (sprite_exists(_icon)) {
		                // Posição do ícone: acima do personagem
		                var _icon_x = _center_x - (sprite_get_width(_icon) / 2) + _icon_offset_x;
		                var _icon_y = _py - sprite_get_height(_icon) - 2; // 2 pixels acima da célula

		                draw_sprite(_icon, 0, _icon_x, _icon_y);

		                // Aumenta o offset para o próximo ícone não sobrepor
		                _icon_offset_x += sprite_get_width(_icon) + 2; // 2 pixels de espaçamento
		            }
		        }
            }
        }
    }
}

/// @function scr_apply_battle_results();
/// @description Sincroniza os resultados dos clones de batalha (HP, XP, Nível)
///              com os personagens persistentes no GameManager.
function scr_apply_battle_results() {
    show_debug_message("--- Aplicando Resultados da Batalha ---");

    // Itera por todos os clones que participaram da batalha
    for (var i = 0; i < array_length(player_party_instances); i++) {
        var _clone = player_party_instances[i];
        var _personagem_persistente = noone;
        
        // Encontra o personagem original no roster do GameManager usando o ID único
        for (var j = 0; j < array_length(global.GameManager.party_roster); j++) {
            if (global.GameManager.party_roster[j].persistent_uid == _clone.persistent_uid) {
                _personagem_persistente = global.GameManager.party_roster[j];
                break;
            }
        }
        
        // Se encontrou a correspondência, sincroniza os dados
        if (_personagem_persistente != noone) {
            show_debug_message("Sincronizando dados para: " + _personagem_persistente.character_info.name);
            
            // Sincroniza os dados de "character_info" (XP, Nível, etc.)
            // Isso salva os level ups que aconteceram no clone.
            _personagem_persistente.character_info = struct_clone(_clone.character_info);
            
            // Sincroniza os dados de "combat_info" (HP, MP, stats base)
            _personagem_persistente.combat_info.hp = _clone.combat_info.hp;
            _personagem_persistente.combat_info.mp = _clone.combat_info.mp;
            _personagem_persistente.combat_info.hp_max = _clone.combat_info.hp_max;
            _personagem_persistente.combat_info.mp_max = _clone.combat_info.mp_max;
            _personagem_persistente.combat_info.attributes_base = struct_clone(_clone.combat_info.attributes_base);
            
            // Recalcula os stats finais no personagem persistente para garantir
            // (Assumindo que você terá uma função para isso no futuro)
            // _personagem_persistente.combat_info.recalculate_stats(); 
        }
    }
}

function scr_update_main_menu_display() {
    ui_options_panel.children = [];
    ui_description_panel.children = [];
    
    for (var i = 0; i < array_length(battle_options); i++) {
		var _is_disabled = (battle_options[i] == "Mover" && !can_move);
        var _color = (i == selected_option) ? c_yellow : c_white;
        var _text = (i == selected_option) ? "> " + battle_options[i] : battle_options[i];
		if (_is_disabled) {
		    _color = c_gray;
		    _text += " X"; 
		}
        var text_element = new UI_Text(0, 0, _text, fnt_ui_main, _color);
        ui_options_panel.add_child(text_element);
    }
    
    // Popula o painel da direita com infos do personagem atual
    if (current_combatant != noone) {
        var info_text = new UI_Text(0,0, "Turno de: " + current_combatant.character_info.name, fnt_ui_main);
        ui_description_panel.add_child(info_text);
    }
}

/// @function update_skill_menu_display();
/// @description Limpa e reconstrói a UI do menu de habilidades com base no personagem atual.
function scr_update_skill_menu_display() {

    // --- Etapa 1: Limpar os painéis da UI ---
    // Removemos os textos antigos para dar lugar aos novos.
    ui_options_panel.children = [];
    ui_description_panel.children = [];
    
    // --- Etapa 2: Obter as "Etiquetas" de Skills do Personagem ---
    // Pegamos a lista de NOMES de skills que o personagem possui.
    var skill_ids = current_combatant.combat_info.skills; // Ex: ["FireBall"]
    
    // Se o personagem não tiver skills, informamos e saímos.
    if (array_length(skill_ids) == 0) {
        var no_skill_text = new UI_Text(0, 0, "Sem Habilidades", fnt_ui_main, c_gray);
        ui_options_panel.add_child(no_skill_text);
        current_ui_menu = UI_MENU.SKILLS; // Mantém no menu para o jogador poder voltar
        exit;
    }
    
    // --- Etapa 3: Construir a Lista de Nomes (Painel da Esquerda) ---
    // Agora, para cada etiqueta, buscamos a informação completa no catálogo.
    for (var i = 0; i < array_length(skill_ids); i++) {
        
        // A PONTE ACONTECE AQUI:
        var current_skill_id = skill_ids[i];   // Pega a etiqueta, ex: "FireBall"
        var skill_data = global.SkillList[$ current_skill_id]; // Usa a etiqueta para buscar o struct completo no catálogo!
		
        // Se a busca falhar (ex: digitou o nome errado), avisa no console.
        if (skill_data == undefined) {
            show_debug_message("AVISO: Skill '" + current_skill_id + "' não encontrada no global.SkillList!");
            continue; // Pula para a próxima skill
        }
        
        // Define o estilo do texto se ele estiver selecionado
        var text_color = (i == skill_menu_selected) ? c_yellow : c_white;
        var skill_name = (i == skill_menu_selected) ? "> " + skill_data.name : skill_data.name;
        
        // Cria o elemento de UI para o nome da skill
        var text_element = new UI_Text(0, 0, skill_name, fnt_ui_main, text_color);
        ui_options_panel.add_child(text_element);
    }
    
    // --- Etapa 4: Construir a Descrição (Painel da Direita) ---
    // Pega os dados completos da skill que está atualmente selecionada
    var selected_skill_id = skill_ids[skill_menu_selected];
    var selected_skill_data = global.SkillList[$ selected_skill_id];
    
    if (selected_skill_data != undefined) {
        // Cria o elemento de UI para o custo de MP
        var mp_cost_element = new UI_Text(0, 0, "Custo MP: " + string(selected_skill_data.costMp), fnt_ui_main);
        
		var skill_type_element = new UI_Text_Description(0, 0, "Tipo: " + string(selected_skill_data.type), fnt_ui_main);
		
		var aoe_type = new UI_Text(0, 0, "Área de Efeito: " + tr(string(selected_skill_data.area_of_effect)), fnt_ui_main);
		
        // Cria o elemento de UI para a descrição
        var description_element = new UI_Text_Description(0, 0, selected_skill_data.description, fnt_ui_main);
        
        // Adiciona os elementos ao painel da direita
        ui_description_panel.add_child(mp_cost_element);
		ui_description_panel.add_child(skill_type_element);
		ui_description_panel.add_child(aoe_type);
        ui_description_panel.add_child(description_element);
    }
    
    // --- Etapa 5: Ativar o Menu de Skills ---
    current_ui_menu = UI_MENU.SKILLS;
}

// Função de UI para o menu de movimento, totalmente reescrita
function scr_update_move_menu_display() {
    var _move_options_base = ["Vanguarda", "Retaguarda", "Flanco"];
    
    // Limpa e reconstrói a lista de movimentos possíveis
    move_menu_options = [];
    for (var i = 0; i < array_length(_move_options_base); i++) {
        if (current_combatant.combat_info.battle_position != _move_options_base[i]) {
            array_push(move_menu_options, _move_options_base[i]);
        }
    }
    
    // Limpa os painéis da UI
    ui_options_panel.children = [];
    ui_description_panel.children = [];
    
    // Popula o painel de opções
    for (var i = 0; i < array_length(move_menu_options); i++) {
        var _option_name = move_menu_options[i];
        var _color = (i == move_menu_selected) ? c_yellow : c_white;
        var _text = (i == move_menu_selected) ? "> " + _option_name : _option_name;
        
        var text_element = new UI_Text(0, 0, _text, fnt_ui_main, _color);
        ui_options_panel.add_child(text_element);
    }
    
    // Popula o painel de descrição
    var desc_text = new UI_Text(0, 0, "Escolha uma nova posição no campo de batalha.", fnt_ui_main);
    ui_description_panel.add_child(desc_text);
    
    // Finalmente, muda para o menu de movimento
    current_ui_menu = UI_MENU.MOVE;
}

function scr_update_item_menu_display(){
    // --- Etapa 1: Limpar os painéis da UI ---
    // Removemos os textos antigos para dar lugar aos novos.
    ui_options_panel.children = [];
    ui_description_panel.children = [];
	show_debug_message("Item quantity: " + string(global.GameManager.inventory.items));
    
    // --- Etapa 2: Obter as "Etiquetas" de Skills do Personagem ---
    // Pegamos a lista de NOMES de skills que o personagem possui.
    var _items = variable_struct_get_names(global.GameManager.inventory.items);
	var _qtd_items = global.GameManager.inventory.length();
    show_debug_message("Items: " + string(_items));
	show_debug_message("Quantidade de itens: " + string(_qtd_items));
	
    // Se o personagem não tiver skills, informamos e saímos.
    if (_qtd_items == 0) {
        var no_skill_text = new UI_Text(0, 0, "Sem Itens", fnt_ui_main, c_gray);
        ui_options_panel.add_child(no_skill_text);
        current_ui_menu = UI_MENU.ITEMS; // Mantém no menu para o jogador poder voltar
        exit;
    }
    
    // --- Etapa 3: Construir a Lista de Nomes (Painel da Esquerda) ---
    // Agora, para cada etiqueta, buscamos a informação completa no catálogo.
    for (var i = 0; i < _qtd_items; i++) {
        
        // A PONTE ACONTECE AQUI:
        var _current_item_id = int64((_items[i]));   // Pega a etiqueta
		show_debug_message("Current item id: " + string(_current_item_id));
	
		var _item_data = global.ItemList[_current_item_id];
		show_debug_message("item_data: " + string(_item_data));
		
        // Define o estilo do texto se ele estiver selecionado
        var _text_color = (i == item_menu_selected) ? c_yellow : c_white;
        var _item_name = (i == item_menu_selected) ? "> " + _item_data.name : _item_data.name;
        
        // Cria o elemento de UI para o nome da skill
        var _text_element = new UI_Text(0, 0, _item_name, fnt_ui_main, _text_color);
        ui_options_panel.add_child(_text_element);
    }
    
    // --- Etapa 4: Construir a Descrição (Painel da Direita) ---
    var _selected_item = global.ItemList[item_menu_selected];
	show_debug_message("Selected item: " + string(_selected_item));
	
    if (_selected_item != undefined) {
        // Cria o elemento de UI para o custo de MP		
        // Cria o elemento de UI para a descrição
		var item_quantity = variable_struct_get(global.GameManager.inventory.items, item_menu_selected);
		var quantity_element = new UI_Text(0, 0, "Quantidade: " + string(item_quantity), fnt_ui_main);
        var description_element = new UI_Text_Description(0, 0, _selected_item.description, fnt_ui_main);
        
        // Adiciona os elementos ao painel da direita
		ui_description_panel.add_child(quantity_element);
        ui_description_panel.add_child(description_element);
    }
    
    // --- Etapa 5: Ativar o Menu de Skills ---
    current_ui_menu = UI_MENU.ITEMS;
}

function scr_enter_victory_state() {
    ui_victory_panel.children = []; // Limpa o painel
    
    var _victory_text = new UI_Text(0, 0, "VITÓRIA!", fnt_ui_main, c_yellow);
	ui_victory_panel.add_child(_victory_text);
	
	var _gold_text = new UI_Text(0, 0, "Gold ganho: " + string(global.GameManager.gold), fnt_ui_main, c_white);
    ui_victory_panel.add_child(_gold_text);
	
    var _ui_char_panel = new UI_Panel(0, 0, room_width, room_height, "horizontal");
	ui_victory_panel.add_child(_ui_char_panel);
	
	for (var _i = 0; _i < array_length(player_party_instances); _i++) {
        var _char_name = player_party_instances[_i].character_info.name;

        var _ui_char_name_text = new UI_Text(0, 0, _char_name, fnt_ui_main, c_white);
        var _ui_char_card = new UI_Panel(0, 0, 64, 128, "vertical");
        var _ui_char_image = new UI_Image(0, 0, spr_eric_attack); // depois trocar pelo retrato correto

        _ui_char_card.spacing = 32;
        _ui_char_card.add_child(_ui_char_image);
        _ui_char_card.add_child(_ui_char_name_text);

        _ui_char_panel.add_child(_ui_char_card);
		ui_victory_panel.update();
    }
	
	ui_victory_panel.update_layout();
	state = BATTLE_STATE.VICTORY;
}

function scr_show_victory_screen(){
	scr_enter_victory_state();
}