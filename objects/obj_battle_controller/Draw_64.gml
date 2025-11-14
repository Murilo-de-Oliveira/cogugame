// 1. Painel de informações do personagem selecionado pelo mouse
if (selected_character != noone) {
    var _info = selected_character.character_info;
    var _combat = selected_character.combat_info;
    var _text = "Nome: " + _info.name + "\n" +
                "HP: " + string(_combat.hp) + "/" + string(_combat.hp_max);
    
    // Desenha na parte de baixo, à direita (exemplo)
    draw_text(200, 200, _text);
}

// 2. Desenha o painel principal da UI (que desenhará seus filhos)
if (state == BATTLE_STATE.PLAYER_INPUT) {
    // Primeiro, atualizamos o conteúdo dos painéis antes de desenhar
    // (Esta lógica pode ser otimizada depois, mas por agora funciona bem)
    if(current_ui_menu == UI_MENU.MAIN) {
        scr_update_main_menu_display(); // Precisaremos criar esta função!
    }
    
    // O painel principal cuida de desenhar tudo que foi populado nele
    ui_main_panel.draw();
}

if (state == BATTLE_STATE.VICTORY){
	ui_victory_panel.update(); // garante que os filhos sincronizem dados
    ui_victory_panel.draw();
}

// --- Desenho do HUD dos Personagens ---
// Se o painel existir...
if (variable_instance_exists(id, "hud_player_panel")) {
    // 1. Manda o HUD se sincronizar com os dados atuais dos personagens
    hud_player_panel.update(); 
    
    // 2. Manda o HUD se desenhar
    hud_player_panel.draw();
}

if (variable_instance_exists(id, "hud_enemy_panel")) {
    // 1. Manda o HUD se sincronizar com os dados atuais dos personagens
    hud_enemy_panel.update(); 
    
    // 2. Manda o HUD se desenhar
    hud_enemy_panel.draw();
}