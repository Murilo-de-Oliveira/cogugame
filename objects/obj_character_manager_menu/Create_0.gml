/// @description Insert description here
// You can write your code in this editor

hero1 = new PlayableCharacter(
    { name: "Eric", class: "Fudido", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { icon: spr_char_icon_base, idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero2 = new PlayableCharacter(
    { name: "Ugo", class: "Druida", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { icon: spr_char_icon_base, idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero3 = new PlayableCharacter(
    { name: "João", class: "da Lolzada", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { icon: spr_char_icon_base, idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero4 = new PlayableCharacter(
    { name: "Higo", class: "com Aga", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { icon: spr_char_icon_base, idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

//party = [hero1, hero2, hero3, hero4]; 
//party = [hero1];
party = [hero1, hero2, hero3, hero4, hero1, hero2, hero3]; 
selected_index = 0;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

ui_menu_display = new UI_Panel(gui_w * 0.1, gui_h * 0.1, gui_w * 0.8, gui_h * 0.8, "vertical");
ui_menu_display.padding = 10;
ui_menu_display.spacing = 100; // Espaço entre as linhas
ui_menu_display.background_visible = true;
ui_menu_display.background_panel_color = c_grey;

var current_row = new UI_Panel(0, 0, ui_menu_display.width - (ui_menu_display.padding * 2), 64, "horizontal");
current_row.spacing = 10; // Espaço entre os personagens

for (var i = 0; i < array_length(party); i++) {
    var _char = party[i];
    
    // Cria a caixa do personagem e adiciona à linha ATUAL
    var char_box_width = (current_row.width / 4) - current_row.spacing; // Ajusta a largura
    var char_box = new UI_CharacterBox(0, 0, char_box_width - current_row.padding, 150, _char);
    current_row.add_child(char_box);
    
    // 4. Verifica se a linha está cheia OU se é o último personagem da lista
    var is_last_char = (i == array_length(party) - 1);
    var is_row_full = ((i + 1) % 4 == 0);
    
    if (is_row_full || is_last_char) {
        // Se a linha estiver cheia ou acabaram os personagens...
        
        // Adiciona a linha preenchida ao container principal
        ui_menu_display.add_child(current_row);
        
        // E cria uma NOVA linha vazia para os próximos personagens (se houver)
        if (!is_last_char) {
            current_row = new UI_Panel(0, 0, ui_menu_display.width - (ui_menu_display.padding * 2), 32, "horizontal");
            current_row.spacing = 10;
        }
    }
}

ui_menu_display.update();