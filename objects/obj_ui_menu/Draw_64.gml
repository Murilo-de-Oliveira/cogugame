/// @description Insert description here
// You can write your code in this editor

draw_rectangle(width * 0.03, menu_height, width * 0.97, height * 0.97, true);

if (current_combatant_icon) {
	draw_sprite_ext(current_combatant_icon, 0, width * 0.05, menu_height, 5, 5, 0, c_white, 1);
}

if (current_ui_menu == UI_BATTLE_MENU_STATE.MAIN){
	for (var i = 0; i < array_length(battle_options); i++) {
	    var _y1 = pos_y + (i * gap_in_items);
    
	    // Mudar a cor se o rato estiver por cima (Hover)
	    draw_set_color(selected_option == i ? c_yellow : c_white);
    
	    // Desenhar o retângulo do botão (opcional, para debug)
	    draw_rectangle(pos_x, _y1, pos_x + 128, _y1 + gap_in_items, true);
    
	    // Desenhar o texto
	    draw_text(pos_x + 10, _y1, battle_options[i]);
	}
}

if (current_ui_menu == UI_BATTLE_MENU_STATE.SKILLS) {
	for (var i = 0; i < array_length(skill_list); i++) {
	    var _skill = skill_list[i];
		
		var _y1 = pos_y + (i * gap_in_items);
		
		if (selected_option == i) {
			draw_rectangle(width * 0.4, menu_height + 16, width * 0.9, (height * 0.97) - 16, true);
			draw_text(width * 0.4, menu_height + 16, _skill[$ "name"]);
			draw_text(width * 0.4, menu_height + 32, "Custo: " + string(_skill[$ "cost"]));
			draw_text_ext(width * 0.4, menu_height + 48, _skill[$ "desc"], 16, width * 0.9 - width * 0.4)
		}
		
		draw_set_color(selected_option == i ? c_yellow : c_white);
		
		draw_rectangle(pos_x, _y1, pos_x + 128, _y1 + gap_in_items, true);
		
		draw_text(pos_x + 10, _y1, _skill[$ "name"]);
	}
}

draw_set_colour(-1);