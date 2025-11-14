/// @description Insert description here
// You can write your code in this editor

//Variáveis
character_list = ["Beinez", "Gusta", "Beto"];

index = 0;

// Posição inicial para a lista da esquerda
list_start_x = 64;
list_start_y = 64;

// Posição e tamanho do grid da direita
grid_start_x = display_get_gui_width() * 0.40; // Ajuste conforme necessário
grid_start_y = display_get_gui_height() * 0.15;
//grid_start_x = camera_get_view_width(view_camera[0]) * 0.4;
//grid_start_y = camera_get_view_height(view_camera[0]) * 0.15;
grid_cell_size = 96; // Tamanho menor para caber mais
grid_cols = 5; // Exemplo: 3 colunas
grid_rows = 5; // Exemplo: 4 linhas

show_debug_message(grid_start_x);
show_debug_message(grid_start_y);

// Array para guardar referências aos botões criados
grid_buttons = array_create();

// --- CRIAÇÃO DOS BOTÕES (Executa apenas UMA VEZ) ---
var _button_index = 0;
for (var j = 0; j < grid_rows; j++) { // Loop por linhas primeiro
    for (var i = 0; i < grid_cols; i++) { // Loop por colunas  
        if(j > 0 && j < grid_rows - 1 && i > 1 && i < grid_cols - 1){
			var _bx1 = grid_start_x + (i * grid_cell_size);
	        var _by1 = grid_start_y + (j * grid_cell_size);
	        var _bx2 = _bx1 + grid_cell_size;
	        var _by2 = _by1 + grid_cell_size;
        
	        // Cria o botão
	        var _button = instance_create_layer(_bx1, _by1, "Instances", obj_add_char_in_party_button); // Use uma layer de GUI
			
	        // Configura as coordenadas corretamente
	        _button.coord.pos_start.x1 = _bx1;
	        _button.coord.pos_start.y1 = _by1;
	        _button.coord.pos_end.x2 = _bx2;   // CORRIGIDO
	        _button.coord.pos_end.y2 = _by2;   // CORRIGIDO
	        _button.text = "+ " + string(i) + string(j); // Texto do botão
        
	        // Define a função a ser chamada quando clicado (exemplo)
	        with (_button) {
			    trigger = function() {
			        show_debug_message("Trigger foi chamado");
			        scr_show_dropdown_menu(coord);
			    };
			}
			
			array_push(grid_buttons, _button);
			show_debug_message(string(grid_buttons));
			
	        //grid_buttons[_button_index] = _button;
	        //_button_index++;
		}
    }
}

function scr_show_dropdown_menu(coords, character_list){
	show_debug_message("scr_show_dropdown_menu");
	_button = instance_create_layer(coords.pos_start.x1, coords.pos_start.y1, "Instances", obj_button_dropdown);
		
	_button.text = character_list;
	_button.trigger();
}

