// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ITEM_ID {
	POTION,
	ETHER,
	PHOENIX_DOWN
}

function Item(_name, _description, _area_of_effect, _type) constructor{
	name = _name;
	description = _description;
	area_of_effect = _area_of_effect;
	type = _type; //pode ser qualquer tipo: consumível, item chave, equipamento
}

function Consumable(_name, _description, _area_of_effect, _effect, _vfx_function) : Item(_name, _description, _area_of_effect, "Consumable") constructor {
    effect = _effect;
    vfx_function = _vfx_function;
}

function Equipment(_name, _description, _status) : Item(_name, _description, noone, "Equipment") constructor {
    status = _status;
}

function KeyItem(_name, _description) : Item(_name, _description, noone, "KeyItem") constructor {
    // nada extra
}

function effect_use_potion(_user, _target){
	show_debug_message("User: " + string(_user));
	show_debug_message("Target: " + string(_target));
	
	var _heal_amount = 20;
	show_debug_message(_user.character_info.name + " usou poção de cura em " + _target.character_info.name);
	scr_apply_health_change(_target, -_heal_amount);
}