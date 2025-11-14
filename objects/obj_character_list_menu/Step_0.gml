// STEP
var _input = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if (_input != 0) {
    selected_index = clamp(selected_index + _input, 0, array_length(party) - 1);
    
    // --- A GRANDE MUDANÇA ---
    // Em vez de destruir e recriar, apenas trocamos a referência do personagem
    // que a caixa de status deve exibir.
    ui_current_box.character = party[selected_index];
}

for(var i  = 0; i < array_length(interactive_elements); i++){
	var element = interactive_elements[i];
	if(i == 0){
		show_debug_message(string(mouse_x) + " | " + string(element.x));
		show_debug_message(string(mouse_y) + " | " + string(element.y));
	}
	if point_in_rectangle(mouse_x, mouse_y, element.x - 16, element.y, element.x + 16, element.y + 32) && !element.is_hovered{
		element.is_hovered = true;
		show_debug_message(is_callable(element.on_hover_enter));
		if (is_callable(element.on_hover_enter)) { 
			show_debug_message("Chegou aqui no on_hover_enter");
			element.on_hover_enter(); 
		}
	}
	if !point_in_rectangle(mouse_x, mouse_y, element.x - 16, element.y, element.x + 16, element.y + 32) && element.is_hovered{
		element.is_hovered = false;
		if (is_callable(element.on_hover_leave)) {
			show_debug_message("Chegou aqui no on_hover_leave");
			element.on_hover_leave(); 
		}
	}
}