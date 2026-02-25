// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Skill(_name, _level, _mp, _m_power, _accuracy, _element, _debuff, _target_type, _description) constructor{
	name = _name;
	level = _level; //não sei se vou usar
	mp = _mp;
	m_power = _m_power; //trocar nome depois, dano base da skill
	accuracy = _accuracy; //ver se vou utilizar, posso substituir por dex ou lck
	element = _element; //pode ser de um elemento ou não
	debuff = _debuff;
	target_type = _target_type;
	description = _description;
	
	static apply_effect = function(){
		//aplicar efeito da skill, pode dar debuff
		//return apply_debuf(_debuff);
	}
	
	static get_text_ui = function(_x, _y){
		draw_set_font(fnt_ui_skill_title);
		draw_text(_x, _y, name);
		draw_set_font(-1);
		draw_text(_x + string_width(name) * 2, _y, level);
		draw_text(_x, _y + 32, "Custo de mana: " + string(mp));
		draw_set_font(fnt_ui_description);
		draw_text(_x, _y + 64, description);
		draw_set_font(-1);
	}
}