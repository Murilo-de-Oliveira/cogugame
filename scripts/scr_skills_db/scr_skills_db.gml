// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


// ============================
// 1. CONSTRUTOR DE HABILIDADES
// ============================

/// @function						Skill()
/// @param {string} _name			Nome da habilidade
/// @param {string} _description	Descrição da habilidade
/// @param {real} _costMp			Custo da habilidade
/// @param {string} _type			Tipo da skill
/// @param {real} _value			Valores de dano/cura/etc
/// @param {string} _typeTarget		Tipo de alvo
/// @param {string} _area_of_effect	Área de efeito
/// @param {function} _effect		Função que executa o efeito
/// @description					Função construtora de habilidades

function Skill(_name, _description, _costMp, _type, _value, _typeTarget, _area_of_effect, _effect, _vfx_function) constructor{ 	
	name = _name;
	description = _description;
	costMp = _costMp;
	value = _value;
	type = _type;
	typeTarget = _typeTarget;
	area_of_effect = _area_of_effect;
	effect = _effect;
	vfx_function = _vfx_function;
}

/// @function						scr_calculate_damage(caster, target, skill)
/// @param {ID.Instance} _caster	Nome da habilidade
/// @param {ID.Instance} _target	Descrição da habilidade
/// @param {Struct} _skill			Custo da habilidade
/// @description					Função que calcula o dano/cura
/// @return							Retorna o valor final do dano/cura

function scr_calculate_power(_caster, _target, _skill){
	var _damage = 0;
	var _attack_power = 0;
	var _defense_power = 0;
	var _heal_power = 0;
	
	switch (_skill.type){ //Ex: "Physical, Magical, Healing"
		case "Physical":
			_attack_power = _caster.combat_info.attributes_final.strength;
			_defense_power = _target.combat_info.resistances.physic; //verificar depois
			_damage = (_attack_power * 2) + _skill.value - _defense_power; //verificar depois
			break;
			
		case "Magical":
            // Dano mágico é baseado na Inteligência do atacante vs Defesa Mágica do alvo
            _attack_power = _caster.combat_info.attributes_final.intelligence;
            _defense_power = _target.combat_info.resistances.magic;
            _damage = (_attack_power * 2) + _skill.value - _defense_power; // Fórmula de exemplo
            break;
            
        case "Healing":
            // Cura é baseada na Fé e não é afetada pela defesa.
            _heal_power = _caster.combat_info.attributes_final.faith;
            // O valor retornado será negativo para podermos sempre "subtrair" do HP.
            _damage = -((_heal_power * 2) + _skill.value);
            break;
	}
	
	if (_target.combat_info.is_defending && _damage > 0) {
        _damage /= 2;
    }
	
	if (_damage > 0) {
        _damage *= random_range(0.9, 1.1); // Variação de 10% para mais ou para menos
    }
	
	return round(_damage);
}

// =================================================================
// 2. AS FUNÇÕES DE EFEITO (A LÓGICA DE CADA HABILIDADE)
//    Estas funções recebem quem usa (caster) e quem recebe (target)
// =================================================================

function effect_fireball(_caster, _target, _skill) {	
    var _dano_final = scr_calculate_power(_caster, _target, _skill);
		
    _target.combat_info.hp -= _dano_final;
    _target.combat_info.hp = clamp(_target.combat_info.hp, 0, _target.combat_info.hp_max);
		
    show_debug_message(_target.character_info.name + " tomou " + string(_dano_final) + " de dano de fogo!");
}

function effect_chain_lightning(_caster, _targets, _skill){
	show_debug_message(_caster.character_info.name + " conjura Chain Lightning!");
    
	// O _targets aqui será um array com todos os inimigos
    for (var i = 0; i < array_length(_targets); i++) {
        var _target = _targets[i];
        var _dano_final = scr_calculate_power(_caster, _target, _skill);
        
        _target.combat_info.hp -= _dano_final;
        _target.combat_info.hp = clamp(_target.combat_info.hp, 0, _target.combat_info.hp_max);
	
        show_debug_message(_target.character_info.name + " tomou " + string(_dano_final) + " de dano elétrico!");
    }
}

// EFEITO PARA BUFF EM SI MESMO
function effect_inner_focus(_caster, _target, _skill) {
    // Para buffs em si mesmo, o _target será o próprio _caster
    show_debug_message(_caster.character_info.name + " usa Inner Focus!");
    
    var _forca_aumentada = _skill.value; // O valor da skill será o quanto de força ganhamos
    _target[0].combat_info.attributes_final.strength += _forca_aumentada;
    
    // TODO: No futuro, criar um sistema de status para que este buff tenha uma duração!
    // Ex: _target.combat_info.status_effects.strength_up = { turns: 3 };
    
    show_debug_message("Força de " + _target[0].character_info.name + " aumentou em " + string(_forca_aumentada) + "!");
}

// EFEITO PARA ATAQUE FÍSICO QUE APLICA UM DEBUFF
function effect_stunning_strike(_caster, _targets, _skill) {
	var _target = _targets[i];
	show_debug_message(_caster.character_info.name + " usa Stunning Strike em " + _target.character_info.name + "!");
    
	// 1. Aplica o dano físico
	var _dano_final = scr_calculate_power(_caster, _target, _skill);
	_target.combat_info.hp -= _dano_final;
	_target.combat_info.hp = clamp(_target.combat_info.hp, 0, _target.combat_info.hp_max);
	show_debug_message(_target.character_info.name + " tomou " + string(_dano_final) + " de dano!");

	// 2. Aplica o efeito negativo (debuff)
	var _is_stunned = false;
	
	for (var j = 0; j < array_length(_target.combat_info.status_effects); j++) {
	    if (_target.combat_info.status_effects[j].effect_key == EFFECT_ID.STUN) {
	        _is_stunned = true;
	        break;
	    }
	}
	
	if (!_is_stunned) {
	    var _stun_instance = new EffectInstance(EFFECT_ID.STUN);
	    array_push(_target.combat_info.status_effects, _stun_instance);
	    show_debug_message(_target.character_info.name + " está atordoado!");
	}
}

function effect_heal(_caster, _target, _skill) {
	var _cura_final = scr_calculate_power(_caster, _target, _skill);
	_target.combat_info.hp -= _cura_final;
	_target.combat_info.hp = clamp(_target.combat_info.hp, 0, _target.combat_info.hp_max);
    show_debug_message(_target.character_info.name + " tomou " + string(_cura_final) + " de cura!");
}

function effect_attack(_caster, _target, _skill) {
	show_debug_message("Chegou aqui");
    var _dano_final = scr_calculate_power(_caster, _target, _skill);
        
    scr_apply_health_change(_target, _dano_final); 
		
    show_debug_message(_target.character_info.name + " tomou " + string(_dano_final) + " de dano de ataque!");
}

function effect_defense(_caster, _target, _skill) {
	_target.combat_info.is_defending = true;
	show_debug_message(_target.character_info.name + " se defendeu");
}

// =================================================================
// 3. INICIALIZAR O BANCO DE DADOS GLOBAL
//    Este struct global vai conter todas as nossas habilidades prontas
// =================================================================