/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_ui_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text(32, 896, menu_title);

switch(menu_title){
	case "Opções":
		for (var i = 0; i < array_length(current_menu); i++) {
			var texto = current_menu[i];
			var _text_y = 320 + 20 + (i * 24);
			var cor = (i == index) ? c_yellow : c_white;
	
			if (i == index) {
		        texto = "> " + texto;
		    }
	
			draw_text_color(64, _text_y, texto, cor, cor, cor, cor, 1);
		}
		break;
		
	case "Habilidade":
		for (var i = 0; i < array_length(current_menu); i++) {
			var _skill = current_menu[i];
	        var _color = (i == index) ? c_yellow : c_white;
	        var _text = (i == index) ? "> " + _skill.name : _skill.name;
        
	        // Cria um elemento de texto e adiciona ao painel da lista
	        var text_element = new ui_text(0, 0, _text, fnt_ui_main, _color);
	        obj_battle_controller.ui_skill_list_panel.add_child(text_element);
	    }
    
	    // Popula o painel da direita com a descrição da skill SELECIONADA
	    if (array_length(current_menu) > 0) {
	        var _selected_skill = current_menu[index];
        
	        var mp_text = new ui_text(0, 0, "MP: " + string(_selected_skill.costMp), fnt_ui_main);
	        // TODO: Alinhar este texto à direita do painel (uma melhoria futura no nosso motor)
        
	        var desc_text = new ui_text(0, 0, _selected_skill.description, fnt_ui_main);
	        // TODO: Fazer este texto quebrar linha (outra melhoria futura)
        
	        obj_battle_controller.ui_skill_desc_panel.add_child(mp_text);
	        obj_battle_controller.ui_skill_desc_panel.add_child(desc_text);
	    }
		break;
}

obj_battle_controller.ui_main_panel.draw();

scr_reset_alignment();
