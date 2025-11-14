/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(vk_down) {
    index = (index + 1) mod array_length(current_menu);
}
if keyboard_check_pressed(vk_up) {
    index = (index - 1 + array_length(current_menu)) mod array_length(current_menu);
}
if keyboard_check_pressed(vk_enter){
	switch(menu_title){
		case "Opções":
			var _option = current_menu[index];
	
			if (_option == "Ataque"){
				index = 0;
				show_debug_message("Ataque");
				if (is_callable(on_action_selected)){
					on_action_selected({
						action_type: "Ataque",
						skill_struct: {}
					});
				}
				instance_destroy();
			} 
	
			else if (_option == "Habilidade"){ 
				array_push(option_tree,skills_list);
				index = 0;
				current_menu = skills_list;
			}
			
			else if (_option == "Defender"){
				index = 0;
				show_debug_message("Defender");
				if (is_callable(on_action_selected)){
					on_action_selected({
						action_type: "Defender",
						skill_struct: {}
					});
				}
				instance_destroy();
			}
			
			else if (_option == "Mover"){
				index = 0;
				show_debug_message("Mover");
				array_push(option_tree, movement_options);
				current_menu = movement_options;
			}
			
			menu_title = _option;
	
			break;
	
		case "Habilidade":
			var _skill_struct = skills_list[index];
		
			show_debug_message("Menu: Habilidade " + _skill_struct.name + " escolhida. Avisando o controller...");
        
			// 1. Verifica se o callback existe
	        if (is_callable(on_action_selected)) {
	            // 2. CHAMA O CALLBACK, passando o resultado
	            on_action_selected({
	                action_type: "Habilidade",
	                skill_struct: _skill_struct
	            });
	        }
        
	        // 3. O trabalho do menu acabou. Ele se autodestrói.
	        instance_destroy();
			break;
		
		case "Mover":
		
			break;
	}
}
if keyboard_check_pressed(vk_escape){
	if(menu_title != "Opções"){
		array_pop(option_tree);
		current_menu = array_last(option_tree);
		menu_title = "Opções";
	}
}
