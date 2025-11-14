// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function						Effect()
/// @param {string} _name			Nome do efeito
/// @param {string} _description	Descrição do efeito
/// @param {real} _turn_duration	Duração do efeito em turnos
/// @param {Instance} _icon			Ícone do efeito
/// @param {function} _effect		Função que executa o efeito
/// @param {real} _value			Valores de dano/cura/etc
/// @description					Função construtora de efeitos
function Effect(_name, _description, _turn_duration, _icon, _effect, _value = 0) constructor {
	name = _name;
	description = _description;
	turn_duration = _turn_duration;
	icon = _icon
	effect = _effect;
	value = _value;
}

/// @function               EffectInstance()
/// @param {real} _effect_id O ID do efeito vindo do enum EFFECT_ID
/// @description            Cria uma cópia de um efeito para ser aplicada a um personagem.
function EffectInstance(_effect_id_enum) constructor {
	var _template = global.EffectList[$ _effect_id_enum];
	
	effect_key = _effect_id_enum;
	
	show_debug_message(_template);
	
	name = _template.name;
    description = _template.description;
    effect = _template.effect;
    value = _template.value;
	icon = _template.icon;
    turns_remaining = _template.turn_duration; // Cada instância tem sua própria contagem de turnos
}

enum EFFECT_ID{
	STUN
}

function effect_stun(){}



