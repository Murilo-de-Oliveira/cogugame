/// @description Insert description here
// You can write your code in this editor

character_info = {
	name: "",
	icon: noone,
	level: 0,
	xp: 0,
	xp_to_next_level: 100,
	class: ""
};

equipments = {
	helmet: noone,
	weapon: noone,
	armor: noone,
	accessory1: noone,
	accessory2: noone
};

sprites = {
    idle: noone,
    attack: noone,
    hurt: noone,
    dead: noone
};

combat_info = {
	hp_max: 0,
	mp_max: 0,
    hp: 0,
    mp: 0,
	is_defending: false,
	status_effect: {},
	
	skills: [],
	
	attributes_base: {
		strength: 0,
		dexterity: 0,
		constitution : 0,
		intelligence: 0,
		faith: 0,
		lucky: 0
	},
	attributes_final: {
		strength: 0,
		dexterity: 0,
		constitution : 0,
		intelligence: 0,
		faith: 0,
		lucky: 0
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
	recalculate_stats: function(){}
};

combat_info.recalculate_stats();