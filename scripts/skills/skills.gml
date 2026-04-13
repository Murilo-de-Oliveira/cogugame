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
	//execute = _execute;
	
	//variáveis de cache da UI
	title_width = 0;
	parsed_description = [];
	line_heigth = 16;
	max_desc_width = 250;
	
	static init_ui_cache = function() {
		//cache  da largura do título
		draw_set_font(fnt_ui_skill_title);
		title_width = string_width(name) * 2;
		
		//cache da descrição
		draw_set_font(fnt_ui_description);
		line_height = string_height("A");
		
		var _color_dict = {
            "fogo": c_red,
            "fogo,": c_red, // Cobrindo com vírgula para garantir
            "fogo.": c_red,
            "água": c_blue,
            "gelo": c_aqua,
            "cura": c_lime,
            "veneno": c_purple
        };
		
		// Divide a descrição em um array de palavras separadas por espaço
        var _words = string_split(description, " ");
        
        for (var i = 0; i < array_length(_words); i++) {
            var _word = _words[i];
            var _lower_word = string_lower(_word); // Tudo minúsculo para comparar
            var _color = c_white; // Cor padrão
            
            // Se a palavra existir no nosso dicionário, muda a cor
            if (variable_struct_exists(_color_dict, _lower_word)) {
                _color = _color_dict[$ _lower_word];
            }
            
            // Guarda a palavra (com o espaço no final), a cor e a largura dela
            array_push(parsed_description, {
                text: _word + " ",
                color: _color,
                width: string_width(_word + " ")
            });
        }
	}
	
	init_ui_cache();
	
	static execute = function(_caster, _target){
		show_debug_message(_caster.name + " usou " + name + " em " + _target.name);
		
		//_caster.stats.mp -= mp;
		
		_target.hurt(m_power, element);
		
		//lógica de aplicar debuff também
		//_target.apply_debuff(generate_debuff(debuff, _target));
		
		//var text = instance_create_layer(x, y, "Instances", obj_floating_text);
		//text.text = string(_damage);
	}
	
	static get_text_ui = function(_x, _y){
        // 1. Desenhando o Título e Nível
        draw_set_font(fnt_ui_skill_title);
        draw_set_color(c_white);
        draw_text(_x, _y, name);
        
        draw_set_font(-1);
        draw_text(_x + title_width, _y, level);
        draw_text(_x, _y + 32, "Custo de mana: " + string(mp));
        
        // 2. Desenhando a Descrição Colorida e com Quebra de Linha
        draw_set_font(fnt_ui_description);
        var _cursor_x = _x;
        var _cursor_y = _y + 64;
        
        for (var i = 0; i < array_length(parsed_description); i++) {
            var _chunk = parsed_description[i];
            
            // Sistema de Quebra de Linha (Word Wrap)
            if (_cursor_x + _chunk.width > _x + max_desc_width) {
                _cursor_x = _x; // Volta pro começo da linha
                _cursor_y += line_height; // Desce uma linha
            }
            
            draw_set_color(_chunk.color);
            draw_text(_cursor_x, _cursor_y, _chunk.text);
            
            _cursor_x += _chunk.width; // Avança o cursor para a próxima palavra
        }
        
        // 3. Resetando as configurações de Draw (MUITO IMPORTANTE!)
        draw_set_color(c_white);
        draw_set_font(-1);
    }
}

function BasicAttack() constructor {
    name = "Atacar";
	target_type = TargetType.SINGLE_ENEMY;
    
    static execute = function(_caster, _target) {
        show_debug_message(_caster.name + " atacou " + _target.name);
        
        var _attack_power = _caster.stats.strength.get_total();
        _target.hurt(_attack_power, Element.PHYSICAL);
    }
}

global.skill_list = {
	fireball: new Skill("Bola de Fogo", 1, 20, 60, 80, Element.FIRE, EffectType.BURN, TargetType.SINGLE_ENEMY, "Atira uma bola de fogo no inimigo"),
	frost_wind: new Skill("Sopro Gélido", 1, 10, 30, 80, Element.ICE, EffectType.NONE, TargetType.SINGLE_ENEMY, "Sopra ar gelado no inimigo"),
	dark_bean: new Skill("Laser Sombrio", 1, 20, 50, 80, Element.DARK, EffectType.NONE, TargetType.SINGLE_ENEMY, "Atira um laser de escuridão no alvo"),
}  
