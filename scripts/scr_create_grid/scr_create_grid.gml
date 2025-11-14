/// @function scr_create_grid()
/// @description Inicializa o ds_grid global para o campo de batalha.
function scr_create_grid() {
    var _rows = 5;
    var _columns = 10;
    var _cell_size = 32; // Definir o tamanho da célula aqui é bom

    // 1. Cria o grid
    global.grid = ds_grid_create(_columns, _rows);

    // 2. Itera por cada coluna (x) e linha (y) para preencher o grid
    for (var _x = 0; _x < _columns; _x++) {
        for (var _y = 0; _y < _rows; _y++) {

            // 3. Define as propriedades padrão para a célula
            var _cell_struct = {
                cell_x: _x * _cell_size, // Posição X em pixels
                cell_y: _y * _cell_size, // Posição Y em pixels
                cell_type: "",           // Tipo da célula (será definido abaixo)
                occupied: false,         // Se está ocupada
                occupant: noone          // Quem está ocupando (se houver)
                // Você pode adicionar mais propriedades aqui no futuro (ex: terrain_effect: "none")
            };

            // 4. Lógica para definir o cell_type com base na posição
            if (_y == 0 || _y == 4) { // Linhas superior e inferior
                if (_x >= 3 && _x <= 6) {
                    _cell_struct.cell_type = "Flanco";
                }
            } else { // Linhas do meio (1, 2, 3)
                if (_x == 1 || _x == 8) {
                    _cell_struct.cell_type = "Retaguarda";
                } else if (_x == 2 || _x == 7) {
                    _cell_struct.cell_type = "Vanguarda";
                }
            }

            // 5. Adiciona a struct da célula finalizada ao grid
            global.grid[# _x, _y] = _cell_struct; // Usando o acessor [# x, y] que é mais rápido e moderno
        }
    }

    show_debug_message("Grid de batalha inicializado (" + string(_columns) + "x" + string(_rows) + ")");
}

/// @function					scr_get_cell_info(grid_x, grid_y);
/// @param {Real} grid_x		A coordenada X no grid.
/// @param {Real} grid_y		A coordenada Y no grid.
/// @description				Retorna a struct completa da célula na posição especificada.
/// @return {Struct|undefined}	A struct da célula ou undefined se as coordenadas forem 
///								inválidas.
function scr_get_cell_info(grid_x, grid_y) {
    // Verificação de segurança para evitar crashes se _x ou _y estiverem fora dos limites
    var _grid_w = ds_grid_width(global.grid);
    var _grid_h = ds_grid_height(global.grid);
    if (grid_x < 0 || grid_x >= _grid_w || grid_y < 0 || grid_y >= _grid_h) {
        show_debug_message("AVISO: Tentativa de acessar célula inválida [" + string(grid_x) + "," + string(grid_y) + "]");
        return undefined;
    }

    // Retorna a struct diretamente do grid
    return global.grid[# grid_x, grid_y];
}

/// @function							scr_set_occupant(grid_x, grid_y, character);
/// @param {Real} grid_x				A coordenada X no grid.
/// @param {Real} grid_y				A coordenada Y no grid.
/// @param {Struct.PlayableCharacter|Struct.EnemyCharacter|noone} _char			O personagem/inimigo a ocupar a célula, ou 'noone' para esvaziar.
/// @description						Atualiza o ocupante de uma célula no grid.
function scr_set_occupant(grid_x, grid_y, _char) {
    // Pega a struct da célula usando nossa função helper
    var _cell = scr_get_cell_info(grid_x, grid_y);

    // Se a célula for válida (não undefined)
    if (_cell != undefined) {
        // Modifica a struct diretamente
        // (Structs em ds_grids são referências, então modificar a cópia modifica o original)
        _cell.occupant = _char;
        _cell.occupied = (_char != noone);

        // Atualiza as coordenadas do personagem (se ele existir)
        if (_char != noone) {
            // Garante que a struct do personagem tenha essas propriedades
            _char.grid_x = grid_x;
            _char.grid_y = grid_y;
        }

        // Não é necessário usar ds_grid_set() novamente, a modificação já foi feita na referência.
    }
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