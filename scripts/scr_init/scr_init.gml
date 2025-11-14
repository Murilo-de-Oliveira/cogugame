// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum CHAR_ID {
	ERIC,
	UGU
};

enum ENEMY_ID {
    GOBLIN,
	ARCHER_GOBLIN
};

//function Init(){

//	global.PlayableCharacters = {};

//	// --- Definição do Eric ---
//	global.PlayableCharacters[CHAR_ID.ERIC] = new PlayableCharacter(
//	    { name: "Eric", class: "Fudido", icon: noone, level: 1, xp: 0, xp_to_next_level: 100 }, // _char_info
//		{ hp_max: 120, mp_max: 100, strength: 15, dexterity: 12, constitution: 14, intelligence: 8, faith: 5, lucky: 10 }, // _base_stats
//	    [], // _skills
//	    //{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead } // _sprites
//		{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead} 
//	);

//	// --- Definição do UGU ---
//	global.PlayableCharacters[CHAR_ID.UGU] = new PlayableCharacter(
//	    { name: "Ugu", class: "Druida", icon: noone, level: 1, xp: 0, xp_to_next_level: 100 }, // _char_info
//	    { hp_max: 80, mp_max: 100, strength: 8, dexterity: 10, constitution: 9, intelligence: 15, faith: 16, lucky: 7 }, // _base_stats
//	    [], // _skills
//	    { idle: noone, attack: noone, hurt: noone, dead: noone } 
//	);
	
//	//INICIALIZADOR DE INIMIGOS

//	global.Enemies = {};

//	global.Enemies[ENEMY_ID.GOBLIN] = new EnemyCharacter(
//	    { name: "Goblin", class: "Guerreiro", icon: noone, level: 1, xp_loot: 100 }, // _char_info
//		{ hp_max: 120, mp_max: 30, strength: 15, dexterity: 0, constitution: 14, intelligence: 8, faith: 5, lucky: 10 }, // _base_stats
//	    ["FireBall", "Attack"], // _skills
//	    //{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead } // _sprites
//		{ idle: noone, attack: noone, hurt: noone, dead: noone },
//		{
//			//lista de prioridades de skills
//			skill_priorities: [
//				{ //prioridade 1: usar attack
//					skill_id: "Attack",
//					//Condição: sempre pode atacar
//					condition: ai_condition_always_true,
//					condition_args: [],
//					//Peso: peso base de 60 (comum)
//					weight: 60
//				},
//				{ //prioridade 2: usar FireBall
//					skill_id: "FireBall",
//					//Condição: só pode usar se tiver MP suficiente
//					condition: ai_condition_can_cast_skill,
//					condition_args: ["FireBall"],
//					//Peso: peso base de 40 (menos comum)
//					weight: 40
//				}
//			]
//		}
//	);
	
	
//	//INICIALIZADOR DE EFEITOS
	
//	global.EffectList = {}

//	global.EffectList.Stun = new Effect(
//		"Atordoamento",
//		"O alvo é impedido de agir por certa quantidade de turnos",
//		1,
//		spr_icon_stun,
//		effect_stun
//	);
	
//	//INICIALIZADOR DE HABILIDADES
	
//	global.SkillList = {};

//	// Criamos as habilidades usando o molde e as funções de efeito
//	global.SkillList.Attack = new Skill(
//		"Ataque",
//		"Causa dano físico a um inimigo.",
//		0,
//		"Physical",
//		10,
//		"Enemy",
//		"SingleTarget",
//		effect_attack,
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.Defense = new Skill(
//		"Defesa",
//		"Se defende de ataques",
//		0,
//		"None",
//		0,
//		"Self",
//		"SingleTarget",
//		effect_defense,
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.FireBall = new Skill(
//	    "Bola de Fogo",
//	    "Causa dano de fogo em um inimigo.",
//	    50, // Custo de MP
//		"Magical",
//	    25, // Potência base
//		"Enemy",
//	    "SingleTarget",
//	    effect_fireball, // Referência à função de efeito
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.Heal = new Skill(
//		"Cura Baixa",
//		"Cura um aliado",
//		23,
//		"Healing",
//		20,
//		"Ally",
//		"SingleTarget",
//		effect_heal,
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.ChainLightning = new Skill(
//	    "Corrente de Raios",
//	    "Causa dano mágico em TODOS os inimigos.",
//	    30, // Custo de MP
//	    "Magical",
//	    15, // Potência base (menor, pois atinge vários)
//	    "Enemy",
//	    "AllEnemies", // <-- Nova área de efeito!
//	    effect_chain_lightning,
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.InnerFocus = new Skill(
//	    "Foco Interior",
//	    "Aumenta a Força do usuário por alguns turnos.",
//	    15,
//	    "Buff", // <-- Novo tipo de "dano"!
//	    10, // Aumenta a força em 10
//	    "Ally", // Alvo é um aliado
//	    "Self", // <-- Área de efeito é apenas em si mesmo!
//	    effect_inner_focus,
//		global.ParticleSystem.create_fire_burst
//	);

//	global.SkillList.StunningStrike = new Skill(
//	    "Golpe Atordoante",
//	    "Um ataque físico que pode atordoar o alvo por 1 turno.",
//	    20,
//	    "Physical",
//	    5, // Dano base baixo, pois o efeito é o principal
//	    "Enemy",
//	    "SingleTarget",
//	    effect_stunning_strike,
//		global.ParticleSystem.create_fire_burst
//	);

//}