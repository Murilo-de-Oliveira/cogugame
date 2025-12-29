/// @description Insert description here
// You can write your code in this editor

for(var _x = 0; _x <= columns; _x++){
	for(var _y = 0; _y <= rows; _y++){
		draw_rectangle(
			(cell_size * _x), 
			(cell_size * _y), 
			(cell_size * (_x - 1) + 1), 
			(cell_size * (_y - 1) + 1), 
			true
		);
	}
}
