// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EffectInstance(_type, _caster, _target) constructor {
	type = _type;
	caster = _caster;
	target = _target;
	
	var _data = global.EFFECT_DATA[type];
	
	turns_remaining = _data.base_turns;
	icon = _data.icon;
	
	static on_apply = function() {
		if (type == EffectType.STUN) {
			//target.can_act = false;
			show_debug_message(target.name + " foi atordoado!");
		}
		else if (type == EffectType.BURN) {
			show_debug_message(target.name + " está com queimadura!");
		}
	}
	
	static on_tick = function() {
		if (type == EffectType.BURN) {
			var _damage = 10;
			target.hurt(_damage);
			show_debug_message(target.name + " sofreu " + string(_damage) + " de dano!")
		}
		else if (type == EffectType.STUN) {
			//target.can_act = false;
		}
		
		turns_remaining--;
	}
	
	static on_remove = function() {
		if (type == EffectType.STUN) {
			target.can_act = true;
			show_debug_message(target.name + " se recuperou do atordoamento");
		}
	}
}