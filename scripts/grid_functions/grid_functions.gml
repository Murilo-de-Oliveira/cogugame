/// @function					scr_get_cell_info(grid_x, grid_y);
/// @param {Real} grid_x		A coordenada X no grid.
/// @param {Real} grid_y		A coordenada Y no grid.
/// @description				Retorna a struct completa da célula na posição especificada.
/// @return {Struct|undefined}	A struct da célula ou undefined se as coordenadas forem 
///								inválidas.
function scr_get_cell_info(grid_x, grid_y) {
    var _grid_w = ds_grid_width(global.grid);
    var _grid_h = ds_grid_height(global.grid);
    if (grid_x < 0 || grid_x >= _grid_w || grid_y < 0 || grid_y >= _grid_h) {
        show_debug_message("AVISO: Tentativa de acessar célula inválida [" + string(grid_x) + "," + string(grid_y) + "]");
        return undefined;
    }

    return global.grid[# grid_x, grid_y];
}

/// @function							scr_set_occupant(grid_x, grid_y, character);
/// @param {Real} grid_x				A coordenada X no grid.
/// @param {Real} grid_y				A coordenada Y no grid.
/// @param {Struct.PlayableCharacter|Struct.EnemyCharacter|noone} _char			O personagem/inimigo a ocupar a célula, ou 'noone' para esvaziar.
/// @description						Atualiza  o ocupante de uma célula no grid.
/// @return {}							Retorna vazio.
function scr_set_occupant(grid_x, grid_y, _char) {
    var _cell = scr_get_cell_info(grid_x, grid_y);

    if (_cell != undefined) {
        _cell.occupant = _char;
        _cell.occupied = (_char != noone);

        //if (_char != noone) {
            // Garante que a struct do personagem tenha essas propriedades
        //    _char.grid_x = grid_x;
        //   _char.grid_y = grid_y;
        //}
    }
	
	return;
}

/// @function								scr_get_occupant(grid_x, grid_y);
/// @param {Real} grid_x					A coordenada X no grid.
/// @param {Real} grid_y					A coordenada Y no grid.
/// @description							Retorna apenas o ocupante da célula.
/// @return {Struct|Id.Instance|Noone|undefined} O ocupante, noone, ou undefined se a célula for 
///											inválida.
function scr_get_occupant(grid_x, grid_y) {
    var _cell = scr_get_cell_info(grid_x, grid_y);
    if (_cell != undefined) {
        return _cell.occupant;
    }
    return undefined; // Retorna undefined se a célula não existe
}

function get_grid_position(pos_x, pos_y) {
	var result_x = (round(pos_x / (cell_size)));
	var result_y = (round(pos_y / (cell_size))) + 1;
	
	return [result_x, result_y];
}