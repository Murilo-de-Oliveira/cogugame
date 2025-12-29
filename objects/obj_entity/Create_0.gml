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
	char_type = "Hero";
	name = _name;
	sprite = _sprites;
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
