scr_draw_battlefield();

if (state == BATTLE_STATE.TARGET_ENEMY || state == BATTLE_STATE.TARGET_ALLY){
	if (mouse_x >= 160 && mouse_x < room_width - 160 && mouse_y >= 32 && mouse_y < 192){
		var _cell_width = 32;
	    var _cell_height = 32;
	    var _x = floor((mouse_x / _cell_width));
	    var _y = floor((mouse_y / _cell_height));
		var _hover_cell = ds_grid_get(global.grid, _x, _y);
	    draw_rectangle(
	        (_x * _cell_width), 
	        (_y * _cell_height), 
	        (_x + 1) * _cell_width, 
	        (_y + 1) * _cell_height, 
	        false
	    );
	}
}