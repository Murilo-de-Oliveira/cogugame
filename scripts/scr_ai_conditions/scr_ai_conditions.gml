// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Em um novo script, scr_ai_conditions.gml

/// @function               ai_condition_always_true(self, allies, enemies, args);
/// @description            Uma condição de IA que sempre permite a ação.
function ai_condition_always_true(_self, _allies, _enemies, _args) {
    return true;
}

/// @function               ai_condition_can_cast_skill(self, allies, enemies, args);
/// @description            Verifica se o usuário tem MP suficiente para a skill.
/// @param {Array} args     Um array onde args[0] é o ID da skill.
function ai_condition_can_cast_skill(_self, _allies, _enemies, _args) {
    var _skill_id = _args[0];
	var _skill_cost = global.SkillList[$ _skill_id].costMp;
    return _self.combat_info.mp >= _skill_cost;
}

/// @function               ai_condition_health_is_low(self, allies, enemies, args);
/// @description            Verifica se a vida do usuário está abaixo de uma porcentagem.
/// @param {Array} args     Um array onde args[0] é a porcentagem (ex: 0.4 para 40%).
function ai_condition_health_is_low(_self, _allies, _enemies, _args) {
    var _percent = _args[0];
    return _self.combat_info.hp < _self.combat_info.hp_max * _percent;
}