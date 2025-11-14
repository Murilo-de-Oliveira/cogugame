// Testar atualização dinâmica
var c = ui_status_panel.character_instance.combat_info;

// faz HP cair
c.hp = max(0, c.hp - 0.2);

// faz MP subir
c.mp = min(c.mp_max, c.mp + 0.1);

// Atualiza o painel
ui_status_panel.update();
