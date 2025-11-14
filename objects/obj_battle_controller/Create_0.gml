/// @description Setup
global.KeywordColors = {
	"physical": c_grey, 
	"físico": c_grey,
	"magical": c_aqua,
	"mágico": c_aqua,
	"fogo": c_red,
	"atordoar": c_yellow
};

global.Translate = {
	"singletarget": "Alvo único",
	"allenemies": "Todos os inimigos",
	"self": "Usuário"
}

//scr_create_grid();
scr_create_grid();

enum BATTLE_STATE{
	SETUP,
	START_TURN,
	PLAYER_INPUT,
	TARGET_ENEMY,
	TARGET_ALLY,
	ENEMY_DECISION,
	EXECUTE_ACTION,
	RESOLVE_ACTION,
	VICTORY,
	DEFEAT,
	NOTHING
}

enum UI_MENU{
	MAIN,
    SKILLS,
	MOVE,
    ITEMS, // Já podemos deixar preparado para o futuro
    TARGETING
}

// Dados da batalha
player_party_instances = [];
enemy_party_instances = [];
turn_queue = [];
background_sprite = noone;

// Dados de controle de estados
state = BATTLE_STATE.SETUP;
current_combatant = noone;
chosen_action = noone;
chosen_targets = noone;
chosen_item = noone;

//Infos
selected_character = noone;

// --- Controle do Menu da UI ---
current_ui_menu = UI_MENU.MAIN; // Começamos sempre no menu principal

// Lista de opções para o menu de habilidades (começa vazia)
skill_menu_options = [];

// Índice da habilidade selecionada
skill_menu_selected = 0;
move_menu_selected = 0;
item_menu_selected = 0;
can_move = true;
move_menu_options = []; // Array para guardar as opções de movimento

// --- Inicialização da UI (usando nomes corrigidos dos construtores) ---
var _ui_height = 360;
var _ui_y_start = display_get_gui_height() - _ui_height;
var _ui_width = display_get_gui_width();

// O painel principal que cobre a área toda
ui_main_panel = new UI_Panel(0, _ui_y_start, _ui_width, _ui_height, "horizontal");
ui_main_panel.spacing = 8;
ui_main_panel.background_visible = true;
ui_main_panel.background_panel_color = c_gray;

// O painel da esquerda para a lista de opções
ui_options_panel = new UI_Panel(0, 0, ui_main_panel.width * 0.4, ui_main_panel.height, "vertical");
ui_main_panel.add_child(ui_options_panel);

// O painel da direita para informações/descrições
ui_description_panel = new UI_Panel(0, 0, ui_main_panel.width * 0.6, ui_main_panel.height, "vertical");
ui_main_panel.add_child(ui_description_panel);

// --- Montagem do HUD da Party ---
// Painel principal do HUD, posicionado no canto inferior esquerdo
hud_player_panel = new UI_Panel(0, 0, display_get_gui_width()/4, _ui_y_start, "vertical");
hud_player_panel.spacing = 128; //muda o espaçamento entre os elementos da hud
hud_player_panel.background_visible = true;
hud_player_panel.background_panel_color = c_dkgray;

hud_enemy_panel = new UI_Panel(display_get_gui_width() - 220, 0, display_get_gui_width()/4, _ui_y_start, "vertical")
hud_enemy_panel.spacing = 128;
hud_enemy_panel.background_visible = true;
hud_enemy_panel.background_panel_color = c_dkgray;

//Painel de vitória
var _panel_w = 300;
var _panel_h = 100;
ui_victory_panel = new UI_Panel(
    (display_get_gui_width() / 2) - (_panel_w / 2),
    (display_get_gui_height() / 2) - (_panel_h / 2),
    _panel_w,
    _panel_h
);
// Para centralizar o texto dentro do painel
ui_victory_panel.padding = 10;

// Esta parte deve rodar DEPOIS que player_party_instances for criado
function setup_player_hud() {
    for (var i = 0; i < array_length(player_party_instances); i++) {
        var _char = player_party_instances[i];
        var status_box = new UI_StatusBox(0, 0, 180, 32, _char);
        hud_player_panel.add_child(status_box);
    }
}

function setup_enemy_hud() {
    for (var i = 0; i < array_length(enemy_party_instances); i++) {
        var _char = enemy_party_instances[i];
        var status_box = new UI_StatusBox(0, 0, 180, 32, _char);
        hud_enemy_panel.add_child(status_box);
    }
}

// --- Variáveis de controle de menu ---
// (Movidas para depois da criação dos painéis, por organização)
current_ui_menu = UI_MENU.MAIN;
battle_options = ["Atacar", "Habilidade", "Defender", "Mover", "Item", "Fugir"];
selected_option = 0;
skill_menu_selected = 0;