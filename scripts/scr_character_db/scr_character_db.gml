// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Criador de personagens
function PlayableCharacter(_template_id, _char_config) constructor {
    
	// --- 1. IDENTIDADE ---
    // As informações básicas são passadas diretamente
    character_info = _char_info; //json
	character_type = "Hero"; //jogo
	persistent_uid = 0; //não sei se vai precisar, talvez num enum
	template_id = 0; //mesma coisa do acima
    
	// --- 2. SPRITES ---
    // Os sprites também
    sprites = {
		//usar esse formato aqui para buscar as coisas no JSON
		//idle: asset_get_index(_char_config.sprites.idle),
	};
	
	// --- 3. STATUS (Data) ---
	//vindos do JSON
	base_stats = {
		hp_max: _base_stats.hp_max,
        mp_max: _base_stats.mp_max,
		str: _base_stats.strength,
		dex: _base_stats.dexterity,
		con: _base_stats.constitution,
		int: _base_stats.intelligence,
		fth: _base_stats.faith,
		lck: _base_stats.luck
    };
	
	current_stats = variable_clone(base_stats);
    
	hp = base_stats.hp_max;
    mp = base_stats.mp_max;
    is_dead = false;
    is_defending = false;
	
	// --- 4. EQUIPAMENTOS E POSIÇÃO ---
    // Criamos as outras estruturas com valores padrão
    equipments = { //adicionados pelo jogo
        helmet: noone,
        weapon: noone,
        armor: noone,
        accessory1: noone,
        accessory2: noone
    };
	
	combat_position = CombatPosition.EMPTY;
	grid_x = 0;
	grid_y = 0;
	
	// --- 5. RESISTÊNCIAS ---
	resistances = array_create(Element.DARK + 1, 1.0);
	//Element.DARK é o maior índice de resistência
	
	if variable_struct_exists(_char_config, "resistances"){
		var _res = _char_config.resistances;
		
		if (variable_struct_exists(_res, "physical")) resistances[Element.PHYSICAL] = _res.fire;
		if (variable_struct_exists(_res, "magic")) resistances[Element.MAGICAL] = _res.fire;
		if (variable_struct_exists(_res, "fire")) resistances[Element.FIRE] = _res.fire;
		if (variable_struct_exists(_res, "ice")) resistances[Element.ICE] = _res.fire;
		//if (variable_struct_exists(_res, "poison")) resistances[Element.POISON] = _res.poison;
		//if (variable_struct_exists(_res, "bleeding")) resistances[Element.BLEEDING] = _res.bleeding;
		if (variable_struct_exists(_res, "lightning")) resistances[Element.LIGHTNING] = _res.lightning;
		if (variable_struct_exists(_res, "dark")) resistances[Element.DARK] = _res.dark;
		//if (variable_struct_exists(_res, "divine")) resistances[Element.DIVINE] = _res.divine;
	}
	
	// --- 6. MÉTODOS ESTÁTICOS ---
	static take_damage = function (_amount, _element) {
		var _multiplier = resistances[_element];
		var _final_damage = _amount * _multiplier;
		
		hp -= _final_damage;
		
		if (hp <= 0) {
            hp = 0;
            is_dead = true;
        }
		
        return _final_damage;
	}
	
	static recalculate_stats = function() {
		// 1. Reseta para a base
        current_stats = variable_clone(base_stats);
        
        // 2. Soma Equipamentos (Exemplo Lógico)
        if (equipments.weapon != noone) {
            current_stats.str += equipments.weapon.stats.atk;
        }
        
        // 3. Atualiza máximos se necessário (sem curar automaticamente)
        // Lógica extra aqui...
	}
}