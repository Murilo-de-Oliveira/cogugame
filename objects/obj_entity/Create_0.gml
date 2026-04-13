/// @description Insert description here
// You can write your code in this editor

//char_id = -1;
//name = "";
//sprite = {};
//stats = {};
//resistances = {};
//grid_x = 0;
//grid_y = 0;

function create_character(_char_id, _name, _sprites, _stats, _resistances, _skills, _grid_x, _grid_y){
	char_id = _char_id;
	name = _name;
	sprites = _sprites;
	current_sprite = variable_struct_get(sprites, "idle");
	stats = _stats;
	stats_text = {
		strength: stats[$ "strength"].get_text_ui(),
		dexterity: stats[$ "dexterity"].get_text_ui(),
		constitution: stats[$ "constitution"].get_text_ui(),
		intelligence: stats[$ "intelligence"].get_text_ui(),
		faith: stats[$ "faith"].get_text_ui(),
		lucky: stats[$ "lucky"].get_text_ui(),
	}
	resistances = _resistances;
	skill_list = _skills;
	effect_list = [];
	order = 0;
	grid_x = _grid_x;
	grid_y = _grid_y;
	x = grid_x * 32;
	y = grid_y * 32;
}

is_defending = false;
is_side = false;
is_dead = false;

function hurt(_raw_damage, _damage_type){
	var _resistance = noone;
	switch(_damage_type){
		case Element.PHYSICAL:
			_resistance = variable_struct_get(resistances, "physical");
			break;
		case Element.MAGICAL:
			_resistance = variable_struct_get(resistances, "magical");
			break;
		case Element.LIGHTNING:
			_resistance = variable_struct_get(resistances, "lightning");
			break;
		case Element.ICE:
			_resistance = variable_struct_get(resistances, "ice");
			break;
		case Element.HOLY:
			_resistance = variable_struct_get(resistances, "holy");
			break;
		case Element.FIRE:
			_resistance = variable_struct_get(resistances, "fire");
			break;
		case Element.DARK:
			_resistance = variable_struct_get(resistances, "dark");
			break;
	}
	
	show_debug_message(_resistance);
	
	var resistance_value = _resistance.get_total();
	var _damage = _raw_damage * (100 - resistance_value)/100;
	
	show_debug_message(name + " sofreu " + string(_damage) + " de dano");
	stats.hp -= _damage;
}

function heal(_health){
	show_debug_message(name + " recebeu " + string(_health) + " de cura");
	stats.hp += _health;
	return;
}

function show_status(_x, _y){
	var _resistances = variable_struct_get_names(resistances);
	
	draw_text(_x, _y + 16 * 1, "Strength: " + stats_text.strength);
	draw_text(_x, _y + 16 * 2, "Dexterity: " + stats_text.dexterity);
	draw_text(_x, _y + 16 * 3, "Constitution: " + stats_text.constitution);
	draw_text(_x, _y + 16 * 4, "Intelligence: " + stats_text.intelligence);
	draw_text(_x, _y + 16 * 5, "Faith: " + stats_text.faith);
	draw_text(_x, _y + 16 * 6, "Lucky: " + stats_text.lucky);
	
	for(var i = 0; i < array_length(_resistances); i++){
		draw_text(_x + 160, _y + (i * 16), _resistances[i] + ": " + string(resistances[$ _resistances[i]] * 100));
	}
	
	if (array_length(self.effect_list) > 0){
		for(var i = 0; i < array_length(self.effect_list); i++){
			draw_sprite_ext(self.effect_list[i].icon, 0, _x + 320, _y, 5, 5, 0, c_white, 1);
		}
	}
}

function apply_effect(_effect_type, _caster){
	var _new_effect = new EffectInstance(_effect_type, _caster, self); 
	
	array_push(effect_list, _new_effect);
	
	_new_effect.on_apply();
}

function process_effect() {
	for (var i = array_length(effect_list)-1; i >= 0; i--){
		var _effect = effect_list[i];
		
		_effect.on_tick();
		
		if (_effect.turn_remaining <= 0) {
			_effect.on_remove();
			array_delete(effect_list, i, 1);
		}
	}
}

function play_attack_animation(chosen_action){
	if chosen_action == ACTION_TYPE.ATTACK {
		current_sprite = variable_struct_get(sprites, "idle");
	}
}
