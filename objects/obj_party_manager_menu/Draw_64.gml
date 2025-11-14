/// @description Insert description here
// You can write your code in this editor

// --- DESENHA A LISTA DA ESQUERDA ---
for (var i = 0; i < array_length(character_list); i++) {
    var selected = (index == i);
    var character = character_list[i]; // No futuro: party[i].character_info.name
    var color = selected ? c_yellow : c_white;
    var text = selected ? "> " + character : "  " + character; // Adiciona espaço para alinhar
    
    draw_set_color(color);
    draw_text(list_start_x, list_start_y + (i * 32), text); // Ajuste o espaçamento vertical (32)
}

// --- DESENHA O GRID DA DIREITA (APENAS VISUAL) ---
// Os botões já se desenham sozinhos! Aqui desenhamos apenas as linhas do grid se necessário.
draw_set_color(c_gray);
for (var j = 0; j < grid_rows; j++) {
    for (var i = 0; i < grid_cols; i++) {
        var _gx1 = grid_start_x + (i * grid_cell_size);
        var _gy1 = grid_start_y + (j * grid_cell_size);
        var _gx2 = _gx1 + grid_cell_size;
        var _gy2 = _gy1 + grid_cell_size;
        draw_rectangle(_gx1, _gy1, _gx2, _gy2, true); // Desenha só a borda
    }
}
draw_set_color(c_white); // Reseta cor

//if instance_exists(grid_buttons[0]){
//	draw_text(0, 0, grid_buttons[0]);
//	draw_text(0, 50, grid_buttons[0].coord);
//	draw_text(0, 100, grid_buttons[0].x);
//	draw_text(0, 120, grid_buttons[0].y);
//}



