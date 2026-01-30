/// @description Insert description here
// You can write your code in this editor

//char_id = -1;
//name = "";
//sprite = {};
//stats = {};
//resistances = {};
//grid_x = 0;
//grid_y = 0;

function create_character(_char_id, _name, _sprites, _stats, _resistances, _grid_x, _grid_y){
	char_id = _char_id;
	name = _name;
	sprites = _sprites;
	stats = _stats;
	resistances = _resistances;
	skills = [
		{"name": "skill1", "cost": 23, "desc": "Magia 1"}, 
		{"name": "skill2", "cost": 11, "desc": "Magia 22222222222222 2222222222 22222222222222 22222222222222222222222222222 222222222222222222222222222222222222222222222222 222222222222222222222222222 2222222222222222222"}
	];
	grid_x = _grid_x;
	grid_y = _grid_y;
	x = grid_x * 32;
	y = grid_y * 32;
}

is_defending = false;
is_side = false;
is_dead = false;

show_debug_message("Posição X: " + string(x));
show_debug_message("Posição Y: " + string(y));

function hurt(_damage){
	stats.hp -= _damage;
	return;
}

function heal(_health){
	stats.hp += _health;
	return;
}

function show_status(_x, _y){
	var _stats = variable_struct_get_names(stats);
	var _resistances = variable_struct_get_names(resistances);
	
	for(var i = 0; i < array_length(_stats); i++){
		draw_text(_x, _y + (i * 16), _stats[i] + ": " + string(stats[$ _stats[i]]));
	}
	
	for(var i = 0; i < array_length(_resistances); i++){
		draw_text(_x + 160, _y + (i * 16), _resistances[i] + ": " + string(resistances[$ _resistances[i]] * 100));
	}
}

//function is_selected(){
//	show_debug_message(name + " foi selecionado");
//}
