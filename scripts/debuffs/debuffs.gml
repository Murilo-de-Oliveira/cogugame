// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum Debuffs {
	STUN,
	BURN,
	NONE
}

function Debuff(_name, _turns_left, _description, _effect, _apply_chance, _target) constructor{
	name = _name;
	turns_left = _turns_left;
	description = _description;
	effect = _effect;
	apply_chance = _apply_chance; 
	target = _target;
}

function apply_debuff(_debuff_name){
	var _name = "";
	var _turns_left = 0;
	var _description = "";
	var _effect = function(){};
	var _apply_chance = 0.0;
	
	switch(_debuff_name){
		case Debuffs.STUN:
			_name = "Atordoamento";
			_turns_left = 1;
			_description = "O personagem não pode realizar ações neste turno";
			break;
		
		case Debuffs.BURN:
			_name = "Queimadura";
			_turns_left = 3;
			_description = "O personagem sofre dano ao fim do turno";
			_effect = function(target){
				show_debug_message(target.name + " sofreu dano de queimadura");
			}
			break;
		
		case Debuffs.NONE:
			return;
	}
	
	return new Debuff(_name, _turns_left, _description, _effect, _apply_chance, _target);
}