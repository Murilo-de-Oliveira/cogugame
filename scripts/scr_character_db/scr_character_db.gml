// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Criador de personagens
function PlayableCharacter(_char_info, _base_stats, _skills, _sprites, _stat_growth) constructor {
    
    // As informações básicas são passadas diretamente
    character_info = _char_info;
	character_type = "Hero";
	persistent_uid = 0;
	template_id = 0;
    
    // Os sprites também
    sprites = _sprites;
    
    // Criamos as outras estruturas com valores padrão
    equipments = {
        helmet: noone,
        weapon: noone,
        armor: noone,
        accessory1: noone,
        accessory2: noone
    };
	
	stat_growth = _stat_growth;
	recalculate_stats = function() { /* ... lógica de recalcular ... */ };
    
    combat_info = {
        hp_max: _base_stats.hp_max,
        mp_max: _base_stats.mp_max,
        hp: _base_stats.hp_max, // Começa com HP cheio
        mp: _base_stats.mp_max, // Começa com MP cheio
        is_defending: false,
		is_dead: false,
        status_effects: [],
        skills: _skills,
        attributes_base: {
            strength: _base_stats.strength,
            dexterity: _base_stats.dexterity,
            constitution: _base_stats.constitution,
            intelligence: _base_stats.intelligence,
            faith: _base_stats.faith,
            luck: _base_stats.luck
        },
        attributes_final: { // Começa como uma cópia do base
            strength: _base_stats.strength,
            dexterity: _base_stats.dexterity,
            constitution: _base_stats.constitution,
            intelligence: _base_stats.intelligence,
            faith: _base_stats.faith,
            luck: _base_stats.luck
        },
        resistances: {
			physic: 0,
			magic: 0,
			fire: 0,
			ice: 0,
			poison: 0,
			bleeding: 0,
			lightning: 0, 
			dark: 0,
			divine: 0
		},
        battle_position: "Vanguarda",
		grid_x: 0,
		grid_y: 0,
    };
}