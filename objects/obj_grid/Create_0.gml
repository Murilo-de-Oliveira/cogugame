/// @description Insert description here
// You can write your code in this editor

rows = 5;
columns = 10;
cell_size = 32;

global.grid = ds_grid_create(columns, rows);

cell_struct = {
	//cell_x: _x * _cell_size,
	//cell_y: _y * _cell_size,
	cell_type: CombatPosition.EMPTY,
	occupied: false,
	occupant: noone
};

for(var _x = 0; _x < ds_grid_width(global.grid); _x++){
	for(var _y = 0; _y < ds_grid_height(global.grid); _y++){
		ds_grid_set(global.grid, _x, _y, cell_struct);
	}
}

show_debug_message("width: " + string(ds_grid_width(global.grid)));
show_debug_message("length: " + string(ds_grid_height(global.grid)));

cell_vanguard = {
	cell_type: CombatPosition.VANGUARD,
	occupied: false,
	occupant: noone
};

cell_rearguard = {
	cell_type: CombatPosition.REARGUARD,
	occupied: false,
	occupant: noone
};

cell_side = {
	cell_type: CombatPosition.SIDE,
	occupied: false,
	occupant: noone
};

ds_grid_set(global.grid, 3, 0, cell_side);
ds_grid_set(global.grid, 4, 0, cell_side);
ds_grid_set(global.grid, 5, 0, cell_side);
ds_grid_set(global.grid, 6, 0, cell_side);
ds_grid_set(global.grid, 3, 4, cell_side);
ds_grid_set(global.grid, 4, 4, cell_side);
ds_grid_set(global.grid, 5, 4, cell_side);
ds_grid_set(global.grid, 6, 4, cell_side);

ds_grid_set(global.grid, 1, 1, cell_rearguard);
ds_grid_set(global.grid, 1, 2, cell_rearguard);
ds_grid_set(global.grid, 1, 3, cell_rearguard);
ds_grid_set(global.grid, 8, 1, cell_rearguard);
ds_grid_set(global.grid, 8, 2, cell_rearguard);
ds_grid_set(global.grid, 8, 3, cell_rearguard);

ds_grid_set(global.grid, 2, 1, cell_vanguard);
ds_grid_set(global.grid, 2, 2, cell_vanguard);
ds_grid_set(global.grid, 2, 3, cell_vanguard);
ds_grid_set(global.grid, 7, 1, cell_vanguard);
ds_grid_set(global.grid, 7, 2, cell_vanguard);
ds_grid_set(global.grid, 7, 3, cell_vanguard);

show_debug_message("Grid de batalha inicializado");
