/// @description Insert description here
// You can write your code in this editor

// Obtém as coordenadas do mouse no espaço da GUI
var _gui_mouse_x = device_mouse_x_to_gui(0);
var _gui_mouse_y = device_mouse_y_to_gui(0);

// Começa assumindo que não está hover
hover = false; 

// Verifica se o mouse está dentro dos limites horizontais E verticais
if (_gui_mouse_x >= coord.pos_start.x1 && _gui_mouse_x < coord.pos_end.x2 &&
    _gui_mouse_y >= coord.pos_start.y1 && _gui_mouse_y < coord.pos_end.y2)
{
    hover = true;
}

// Lógica de clique (exemplo, adicione se precisar)
if (hover && mouse_check_button_pressed(mb_left)) {
    // Executa a ação do botão
    if (script_exists(trigger)) { // Verifica se 'trigger' é uma função válida
        show_debug_message("Trigou");
		script_execute(trigger);
    }
    show_debug_message(text + " clicado!");
}