// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//global.KeywordColors = {
//	"physical": c_grey, 
//	"físico": c_grey,
//	"magical": c_aqua,
//	"mágico": c_aqua,
//	"fogo": c_red,
//	"atordoar": c_yellow
//};

global.KeywordColors = {}
global.KeywordColors[$ Element.PHYSICAL] = c_grey;
global.KeywordColors[$ Element.MAGICAL] = c_aqua;
global.KeywordColors[$ Element.FIRE] = c_red;

global.Translate = {
	"singletarget": "Alvo único",
	"allenemies": "Todos os inimigos",
	"self": "Usuário"
}

enum BATTLE_STATE {
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

enum UI_BATTLE_MENU_STATE {
	MAIN,
    SKILLS,
	MOVE,
    ITEMS, // Já podemos deixar preparado para o futuro
    TARGETING
}

enum UI_GAME_MENU_STATE {
	IDLE,
	CONTINUE,
	PARTY,
	CHARACTERS,
	INVENTORY,
	QUIT
}

enum Stats {
	HP_MAX,
	MP_MAX,
	HP,
	MP,
	STR,
	DEX,
	CON,
	INT,
	FTH,
	LCK
}

enum Element {
    PHYSICAL,
	MAGICAL,
    FIRE,
    ICE,
    LIGHTNING,
    HOLY,
    DARK
}

enum TargetType {
    ALLY,
    ENEMY
}

enum CombatPosition {
	EMPTY,
	VANGUARD,
	REARGUARD,
	SIDE
}

enum Characters {
	ERIC,
	UGU
}