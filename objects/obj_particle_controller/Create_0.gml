/// @description Inicializa o sistema de partículas e define todos os tipos e efeitos.

global.ParticleSystem = id;

// 1. Cria o sistema de partículas
self.particle_system = part_system_create_layer("Instances", false);

// 2. Define os tipos de partículas (variáveis da instância!)

// --- Faíscas de impacto físico ---
self.p_spark = part_type_create();
part_type_shape(self.p_spark, pt_shape_spark);
part_type_size(self.p_spark, 0.10, 0.20, -0.005, 0);
part_type_color1(self.p_spark, c_white);
part_type_alpha1(self.p_spark, 1);
part_type_speed(self.p_spark, 1, 3, -0.05, 0);
part_type_direction(self.p_spark, 0, 359, 0, 20);
part_type_life(self.p_spark, 15, 30);

// --- Partículas de fogo ---
self.p_fire = part_type_create();
part_type_shape(self.p_fire, pt_shape_flare);
part_type_size(self.p_fire, 0.2, 0.5, -0.01, 0);
part_type_color_mix(self.p_fire, c_yellow, make_color_rgb(150, 0, 0)); 
part_type_alpha3(self.p_fire, 1, 0.8, 0);
part_type_speed(self.p_fire, 0.5, 1, 0, 0);
part_type_direction(self.p_fire, 80, 100, 0, 0);
part_type_gravity(self.p_fire, 0.05, 270);
part_type_life(self.p_fire, 30, 60);

// --- Partículas de cura ---
self.p_heal = part_type_create();
part_type_shape(self.p_heal, pt_shape_pixel);
part_type_size(self.p_heal, 2, 2, 0, 0);
part_type_color1(self.p_heal, c_lime);
part_type_alpha2(self.p_heal, 1, 0);
part_type_speed(self.p_heal, 0.5, 1, 0, 0);
part_type_direction(self.p_heal, 80, 100, 0, 5);
part_type_life(self.p_heal, 40, 70);

self.p_ice = part_type_create();
part_type_shape(self.p_ice, pt_shape_pixel);
part_type_size(self.p_ice, 2, 2, 0, 0);
part_type_color1(self.p_ice, c_lime);
part_type_alpha2(self.p_ice, 1, 0);
part_type_speed(self.p_ice, 0.5, 1, 0, 0);
part_type_direction(self.p_ice, 80, 100, 0, 5);
part_type_life(self.p_ice, 40, 70);

// 3. Cria as funções (presas ao objeto via self!)

self.create_physical_hit = function(_x, _y) {
    part_particles_create(self.particle_system, _x, _y, self.p_spark, irandom_range(10, 15));
};

self.create_fire_burst = function(_x, _y) {
    part_particles_create(self.particle_system, _x, _y, self.p_fire, irandom_range(20, 25));
};

self.create_heal_effect = function(_x, _y) {
    part_particles_create(self.particle_system, _x, _y, self.p_heal, irandom_range(15, 20));
};

//DESCE MAIS!!!



enum GameStatus{
	COMBAT,
	MENU,
	EXPLORE
}

global.GameManager = {
	game_status: GameStatus.COMBAT,
	party_roster: [],
	current_party: [],
	gold: 100,
	
	// --- Struct do Inventário ---
	inventory: {
		items: {},
		add: function(_item_id, _quantity = 1){
			if (variable_struct_exists(self.items, _item_id)){
				items[$ _item_id] += _quantity;
			}
			else {
				items[$ _item_id] = _quantity;
			}
		},
		remove: function(_item_id, _quantity = 1) {
            if (self.has(_item_id)) {
                items[$ _item_id] -= _quantity;
                if (items[$ _item_id] <= 0) {
                    variable_struct_remove(self.items, _item_id);
                }
                return true;
            }
            return false;
        },
		has: function(_item_id) {
            return variable_struct_exists(self.items, _item_id) && self.items[$ _item_id] > 0;
        },
        
        /// @function use(item_id, user, target)
        use: function(_item_id, _user, _target) {
            if (self.has(_item_id)) {
                var item_data = global.ItemList[_item_id];
                
                // Executa o efeito do item
                item_data.effect(_user, _target);
                
                // Remove 1 item do inventário
                self.remove(_item_id, 1);
                
                return true;
            }
            show_debug_message("Não possui o item " + global.ItemList[_item_id].name);
            return false;
        },
		length: function(){
			return (variable_struct_names_count(self.items));
		}
	}
}

global.PlayableCharacters = {};

// --- Definição do Eric ---
global.PlayableCharacters[CHAR_ID.ERIC] = new PlayableCharacter(
	{ name: "Eric", class: "Fudido", icon: noone, level: 1, xp: 0, xp_to_next_level: 100 }, // _char_info
	{ hp_max: 120, mp_max: 100, strength: 15, dexterity: 12, constitution: 14, intelligence: 8, faith: 5, luck: 10 }, // _base_stats
	["FireBall", "Heal"], // _skills
	//{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead } // _sprites
	{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead}, 
	{hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1}
);

// --- Definição do UGU ---
global.PlayableCharacters[CHAR_ID.UGU] = new PlayableCharacter(
	{ name: "Ugu", class: "Druida", icon: noone, level: 1, xp: 0, xp_to_next_level: 100 }, // _char_info
	{ hp_max: 80, mp_max: 100, strength: 8, dexterity: 10, constitution: 9, intelligence: 15, faith: 16, luck: 7 }, // _base_stats
	["FireBall", "InnerFocus", "StunningStrike","ChainLightning"], // _skills
	{ idle: noone, attack: noone, hurt: noone, dead: noone },
	{hp_max: 8, mp_max: 10, strength: 1, dexterity: 2, constitution: 1, intelligence: 4, faith: 4, luck: 1}
);
	
//INICIALIZADOR DE INIMIGOS

global.Enemies = {};

global.Enemies[ENEMY_ID.GOBLIN] = new EnemyCharacter(
	{ name: "Goblin", class: "Guerreiro", icon: noone, level: 1, xp_loot: 100 }, // _char_info
	{ hp_max: 120, mp_max: 30, strength: 15, dexterity: 0, constitution: 14, intelligence: 8, faith: 5, luck: 10 }, // _base_stats
	["FireBall", "Attack"], // _skills
	//{ idle: spr_eric_idle, attack: spr_eric_attack, hurt: spr_eric_hurt, dead: spr_eric_dead } // _sprites
	{ idle: noone, attack: noone, hurt: noone, dead: noone },
	{
		//lista de prioridades de skills
		skill_priorities: [
			{ //prioridade 1: usar attack
				skill_id: "Attack",
				//Condição: sempre pode atacar
				condition: ai_condition_always_true,
				condition_args: [],
				//Peso: peso base de 60 (comum)
				weight: 60
			},
			{ //prioridade 2: usar FireBall
				skill_id: "FireBall",
				//Condição: só pode usar se tiver MP suficiente
				condition: ai_condition_can_cast_skill,
				condition_args: ["FireBall"],
				//Peso: peso base de 40 (menos comum)
				weight: 40
			}
		]
	}
);
	
	
//INICIALIZADOR DE EFEITOS
	
global.EffectList = {}

global.EffectList.Stun = new Effect(
	"Atordoamento",
	"O alvo é impedido de agir por certa quantidade de turnos",
	1,
	spr_icon_stun,
	effect_stun
);
	
//INICIALIZADOR DE HABILIDADES
	
global.SkillList = {};

// Criamos as habilidades usando o molde e as funções de efeito
global.SkillList.Attack = new Skill(
	"Ataque",
	"Causa dano físico a um inimigo.",
	0,
	"Physical",
	10,
	"Enemy",
	"SingleTarget",
	effect_attack,
	method(global.ParticleSystem, global.ParticleSystem.create_physical_hit)
);

global.SkillList.Defense = new Skill(
	"Defesa",
	"Se defende de ataques",
	0,
	"None",
	0,
	"Self",
	"SingleTarget",
	effect_defense,
	noone
);

global.SkillList.FireBall = new Skill(
	"Bola de Fogo",
	"Causa dano de fogo em um inimigo.",
	50, // Custo de MP
	"Magical",
	25, // Potência base
	"Enemy",
	"SingleTarget",
	effect_fireball, // Referência à função de efeito
	method(global.ParticleSystem, global.ParticleSystem.create_fire_burst)
);

global.SkillList.Heal = new Skill(
	"Cura Baixa",
	"Cura um aliado",
	23,
	"Healing",
	20,
	"Ally",
	"SingleTarget",
	effect_heal,
	method(global.ParticleSystem, global.ParticleSystem.create_heal_effect)
);

global.SkillList.ChainLightning = new Skill(
	"Corrente de Raios",
	"Causa dano mágico em TODOS os inimigos.",
	30, // Custo de MP
	"Magical",
	15, // Potência base (menor, pois atinge vários)
	"Enemy",
	"AllEnemies", // <-- Nova área de efeito!
	effect_chain_lightning,
	method(global.ParticleSystem, global.ParticleSystem.create_fire_burst)
);

global.SkillList.InnerFocus = new Skill(
	"Foco Interior",
	"Aumenta a Força do usuário por alguns turnos.",
	15,
	"Buff", // <-- Novo tipo de "dano"!
	10, // Aumenta a força em 10
	"Ally", // Alvo é um aliado
	"Self", // <-- Área de efeito é apenas em si mesmo!
	effect_inner_focus,
	noone
);

global.SkillList.StunningStrike = new Skill(
	"Golpe Atordoante",
	"Um ataque físico que pode atordoar o alvo por 1 turno.",
	20,
	"Physical",
	5, // Dano base baixo, pois o efeito é o principal
	"Enemy",
	"SingleTarget",
	effect_stunning_strike,
	method(global.ParticleSystem, global.ParticleSystem.create_physical_hit)
);

global.ItemList = {};
global.ItemNameToEnum = {};
show_debug_message(global.ItemList);

function register_item(_enum_id, _name, _object) {
    // 1. Salva no banco principal
    global.ItemList[_enum_id] = _object;

    // 2. Mapeia o nome em lowercase pro enum
    var _key = string_lower(_name);
    global.ItemNameToEnum[$ _key] = _enum_id;
}

register_item(
    ITEM_ID.POTION,
    "Poção",
    new Consumable(
        "Poção",
        "Restaura 20 HP de um aliado.",
        "SingleTarget",
        effect_use_potion,
        method(global.ParticleSystem, global.ParticleSystem.create_heal_effect)
    )
);

global.GameManager.inventory.add(ITEM_ID.POTION);
