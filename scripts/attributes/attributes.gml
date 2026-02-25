// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Attribute(_valor_base) constructor{
	base = _valor_base;
	bonus_equipment = 0;
	bonus_state = 0;
	
	static get_total = function() {
		var _total = base + bonus_equipment + bonus_state;
		return max(0, _total);
	}
	
	static get_text_ui = function() {
		var _text = string(get_total());
		
		var _bonus_total = bonus_equipment + bonus_state;
        if (_bonus_total > 0) {
            _text += " (+" + string(_bonus_total) + ")";
        } else if (_bonus_total < 0) {
            _text += " (" + string(_bonus_total) + ")";
        }
		
		return _text;
	}
}