// CREATE Event de obj_party_manager_menu

// Pega os dados REAIS do jogo, não cria um herói do zero
//party = global.GameManager.party_roster;
hero1 = new PlayableCharacter(
    { name: "Eric", class: "Fudido", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero2 = new PlayableCharacter(
    { name: "Ugo", class: "Druida", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero3 = new PlayableCharacter(
    { name: "João", class: "da Lolzada", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

hero4 = new PlayableCharacter(
    { name: "Higo", class: "com Aga", icon: noone, level: 40, xp: 0, xp_to_next_level: 100 },
    { hp_max: 2534, mp_max: 892, strength: 39, dexterity: 38, constitution: 46, intelligence: 92, faith: 50, luck: 20 },
    [],
    { idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead },
    { hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1 }
);

party = [hero1, hero2, hero3, hero4]; 
selected_index = 0;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
show_debug_message("gui_w: " + string(gui_w));
show_debug_message("gui_h: " + string(gui_h));

// Cria os painéis principais
ui_menu_display = new UI_Panel(gui_w * 0.1, gui_h * 0.1, gui_w * 0.9, gui_h * 0.9, "horizontal");
ui_menu_display_left = new UI_Panel(0, 0, ui_menu_display.width * 0.3, ui_menu_display.height, "vertical");
ui_menu_display_right = new UI_Panel(0, 0, ui_menu_display.width * 0.7, ui_menu_display.height, "vertical");

// Cria a caixa de status do personagem UMA ÚNICA VEZ
// Passamos o primeiro personagem da party como o personagem inicial a ser exibido
ui_current_box = new UI_CharacterStatusBox(0, 0, ui_menu_display_right.width, ui_menu_display_right.height, party[selected_index]);

// Monta a hierarquia da UI
ui_menu_display_right.add_child(ui_current_box);
ui_menu_display.add_child(ui_menu_display_left);
ui_menu_display.add_child(ui_menu_display_right);

// Não precisamos chamar update_layout() aqui, pois add_child() já faz isso.

helmet = new Equipment(
	"Capacete Maluco",
	"Capacete muito do maluco",
	{
		str: 10
	}
);

hero1.equipments.helmet = helmet;

interactive_elements = [];
tooltip_text = "";
tooltip_visible = false;
tooltip_x = 0;
tooltip_y = 0;
show_tooltip = function(_text){
	tooltip_visible = true;
	tooltip_x = mouse_x;
	tooltip_y = mouse_y;
	tooltip_text = _text;
}
hide_tooltip = function(){
	tooltip_visible = false;
}

