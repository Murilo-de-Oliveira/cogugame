// Draw GUI Event de obj_party_manager_menu

// --- FASE 2: ATUALIZAR CONTEÚDO ---
// Esta parte reconstrói a lista de nomes para garantir que o ">" e a cor estejam no lugar certo.
ui_menu_display_left.children = []; // Limpa a lista da esquerda
for (var i = 0; i < array_length(party); i++) {
    var _char_name = party[i].character_info.name;
    var _color = (i == selected_index) ? c_yellow : c_white;
    var _prefix = (i == selected_index) ? "> " : "  ";
    
    var _text = new UI_Text(0, 0, _prefix + _char_name, fnt_ui_main, _color);
    // add_child aqui chama o update_layout SÓ do painel da esquerda, o que é bom.
    ui_menu_display_left.add_child(_text); 
}

// --- FASE 3: SINCRONIZAR DADOS ---
// O update recursivo garante que o UI_StatusBox pegue os dados mais recentes do personagem selecionado.
ui_menu_display.update();

// --- FASE 4: CALCULAR LAYOUT ---
// ESTA É A CHAMADA QUE FALTAVA!
// Manda o painel principal (e todos os seus filhos, em cascata) se reorganizarem.
//ui_menu_display.update_layout();

// --- FASE 5: DESENHAR ---
// Agora que tudo está atualizado e no lugar certo, desenhamos.
ui_menu_display.draw();

if(tooltip_visible){
	draw_set_font(fnt_ui_description);
	draw_set_color(c_grey);
	draw_rectangle(tooltip_x, tooltip_y, tooltip_x + 300, tooltip_y + 24, false);
	draw_set_color(-1);
	draw_text(tooltip_x, tooltip_y, tooltip_text);
	draw_set_font(-1);
}