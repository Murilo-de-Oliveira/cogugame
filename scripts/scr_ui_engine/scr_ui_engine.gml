// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function text_to_colored_parts(_text, _default_color)
/// @description Colore partes específicas do texto
/// @param {String} _text Texto que terá palavras coloridas
/// @param {Constant.Color} _default_color Cor padrão que será aplicada ao texto
/// @return {Array<Struct>} Retorna um array em que, se existe uma palavra com uma cor
//							diferente, retorna uma Struct que possui a cor agregada a palavra

function text_to_colored_parts(_text, _default_color){
	var _words = string_split(_text, " ");
	var _parts = [];
	
	for (var _i = 0; _i < array_length(_words); _i++){
		var _w = _words[_i];
		var _lw = string_lower(_w);
		
		var _clean = string_replace_all(_lw, ".", "");
        _clean = string_replace_all(_clean, ",", "");
        _clean = string_replace_all(_clean, "!", "");
        _clean = string_replace_all(_clean, "?", "");
		
		var _color = _default_color;
        if (variable_struct_exists(global.KeywordColors, _clean)) {
            _color = global.KeywordColors[$ _clean];
        }
        
        array_push(_parts, { text: _w + " ", color: _color }); // mantém espaço
	}
	
	return _parts;
}

function tr(_key) {
    var _lk = string_lower(_key);
    if (variable_struct_exists(global.Translate, _lk)) {
        return global.Translate[$ _lk];
    }
    return _key; // fallback se não existir tradução
}

/**
 * Representa um elemento que será desenhado na tela
 * @param {real} _x Posição horizontal do elemento
 * @param {real} _y Posição vertical do elemento
 * @param {real} _w Largura do elemento
 * @param {real} _h Altura do elemento
**/
function UI_Element(_x, _y, _w, _h) constructor {
	x = _x;
	y = _y;
	width = _w;
	height = _h;
	
	static update = function (){
		//
	}

	static draw = function(){
		//	
	}
}

function UI_Text_Description(_x, _y, _text, _font, _color = c_white) : UI_Element(_x, _y, 0, 0) constructor{
	text = _text;
	if (is_string(_text)) {
        text = text_to_colored_parts(text, _color);
    } else {
        text = _text; // já veio como array de partes
    }
    font = _font;
    color = _color;
    
    // Calcula o próprio tamanho!
    draw_set_font(font);
	width = 0;
    height = 0;
    for (var _i = 0; _i < array_length(text); _i++) {
        width += string_width(text[_i].text);
        height = max(height, string_height(text[_i].text));
    }
    
    // Sobrescreve o método de desenho
    static draw = function() {
        draw_set_font(font);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        var _offset_x = 0;
        for (var _i = 0; _i < array_length(text); _i++) {
            var _p = text[_i];
            draw_set_color(_p.color);
            draw_text(x + _offset_x, y, _p.text);
            _offset_x += string_width(_p.text);
        }
    }
}

function UI_Text(_x, _y, _text, _font, _color = c_white) : UI_Element(_x, _y, 0, 0) constructor {
	text = _text;
    font = _font;
    color = _color;
    
    // Calcula o próprio tamanho!
    draw_set_font(font);
    width = string_width(text);
    height = string_height(text);
    
    // Sobrescreve o método de desenho
    static draw = function() {
        draw_set_font(font);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text_color(x, y, text, color, color, color, color, 1);
    }
}

function UI_Panel(_x, _y, _w, _h, _layout = "vertical") : UI_Element(_x, _y, _w, _h) constructor {
    children = []; // Lista de elementos filhos
    layout_mode = _layout; // "vertical" ou "horizontal"
    padding = 10; // Espaçamento interno
    spacing = 5;  // Espaçamento entre os filhos
	background_visible = false;
    background_panel_color = c_black;

    // Método para adicionar um filho ao painel
    static add_child = function(_element) {
        array_push(children, _element);
        update_layout(); // Reorganiza tudo sempre que um novo filho é adicionado
    }
    
    // O CORAÇÃO DO SISTEMA: Organiza os filhos automaticamente
    static update_layout = function() {
        var _current_x = x + padding;
        var _current_y = y + padding;
        
        for (var i = 0; i < array_length(children); i++) {
            var _child = children[i];
            
            // Posiciona o filho
            _child.x = _current_x;
            _child.y = _current_y;
            
            // ATUALIZAÇÃO IMPORTANTE: Manda o filho se auto-organizar também!
            // Se o filho também for um painel, ele precisa rodar sua própria organização interna.
            if (is_instanceof(_child, UI_Panel)) {
                _child.update_layout();
            }
            
            // Atualiza a posição para o próximo filho
            if (layout_mode == "vertical") {
                _current_y += _child.height + spacing;
            } else { // horizontal
                _current_x += _child.width + spacing;
            }
        }
    }
	
	static update = function() {
        // Manda cada filho se atualizar
        for (var i = 0; i < array_length(children); i++) {
            children[i].update();
        }
    }
    
    // Sobrescreve o método de desenho para desenhar a si mesmo E os filhos
    static draw = function() {
        // Desenha um fundo para o painel (opcional)
        // draw_rectangle_color(x, y, x + width, y + height, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
        
		if (background_visible) {
            draw_set_color(background_panel_color);
            draw_set_alpha(0.5); // Exemplo de alfa
            draw_rectangle(x, y, x + width, y + height, false);
            draw_set_alpha(1.0);
        }
		
        // Manda cada filho se desenhar
        for (var i = 0; i < array_length(children); i++) {
            children[i].draw();
        }
    }
}

/// @function UI_ProgressBar(_x, _y, _w, _h, _max_val, _color, _back_color)
function UI_ProgressBar(_x, _y, _w, _h, _max_val, _back_color, _color) : UI_Element(_x, _y, _w, _h) constructor {
    max_value = _max_val;
    current_value = _max_val; // Começa cheia
    base_color = _color;
    bar_background_color = _back_color;
    
    // Método para atualizar o valor da barra
    static set_value = function(_val) {
        current_value = clamp(_val, 0, max_value);
    }
    
    // Sobrescreve o método de desenho
    static draw = function() {
        // Calcula a largura da barra preenchida
        var _fill_width = (current_value / max_value) * width;
		
		var _draw_color = base_color; 
		
		//c_lime indica ser uma barra de vida
		if (base_color == c_lime){
			var _percent = (current_value / max_value);
		
			if (_percent >= 0.75){
				_draw_color = c_lime;
			}
			else if (_percent >= 0.50 && _percent < 0.75){
				_draw_color = c_green;
			}
			else if (_percent >= 0.25 && _percent < 0.50){
				_draw_color = c_yellow;
			}
	        else {
				_draw_color = c_red;
			}
		}
		
        // 3. Desenha o fundo da barra
        draw_rectangle_color(x, y, x + width, y + height, bar_background_color, bar_background_color, bar_background_color, bar_background_color, false);
        
        // 4. Desenha a parte preenchida com a cor temporária calculada
        if (_fill_width > 0) {
            draw_rectangle_color(x, y, x + _fill_width, y + height, _draw_color, _draw_color, _draw_color, _draw_color, false);
        }
    }
}

/// @function UI_Image(_x, _y, _sprite)
/// @description Um elemento de UI que desenha um sprite.
function UI_Image(_x, _y, _sprite) : UI_Element(_x, _y, 0, 0) constructor {
    sprite = _sprite;

    // Calcula o tamanho com base no sprite
    if (sprite_exists(sprite)) {
        width = sprite_get_width(sprite);
        height = sprite_get_height(sprite);
    }

    static draw = function() {
        if (sprite_exists(sprite)) {
            draw_sprite(sprite, 0, x, y);
        }
    }
}

function UI_Button(_x, _y) : UI_Element(_x, _y, 16, 16) constructor{
	is_hovered = false;
	on_hover_enter = noone;
	on_hover_leave = noone;
	on_click = noone;
	
	static update = function(){
		is_hovered = true;
	}
	
	static draw = function(){
		if is_hovered{
			draw_set_color(c_aqua);
			draw_rectangle(x-8, y-8, x+8, y+8, false);
			draw_set_color(-1);
		}
		else{
			draw_set_color(c_grey);
			draw_rectangle(x-16, y, x+16, y+32, false);
			draw_set_color(-1);
			draw_text(x-8, y-4, "?");
		}
	}
} 

/// @function UI_StatusBox(_x, _y, _w, _h, _character)
function UI_StatusBox(_x, _y, _w, _h, _character) : UI_Panel(_x, _y, _w, _h, "vertical") constructor {
    character_instance = _character;
    spacing = 2; // Espaçamento menor para este componente
	
    // --- Cria os elementos internos da caixa ---
    var _info = character_instance.character_info;
    var _combat = character_instance.combat_info;
    
    // 1. Nome do Personagem
    name_text = new UI_Text(0, 0, _info.name, fnt_ui_main);
    
    // 2. Barra de HP
    hp_bar = new UI_ProgressBar(0, 0, width - (padding * 2), 16, _combat.hp_max, c_dkgray, c_lime);
    
    // 3. Texto do HP (ex: "120/120")
    hp_text = new UI_Text(0, 0, "", fnt_ui_main);
    
    // 4. Barra de MP
    mp_bar = new UI_ProgressBar(0, 0, width - (padding * 2), 16, _combat.mp_max, c_dkgray, c_blue);
    
    // 5. Painel para os ícones de status
    status_icon_panel = new UI_Panel(0, 0, width - (padding * 2), 16, "horizontal");
    
    // Adiciona todos como filhos para serem organizados automaticamente
    add_child(name_text);
    add_child(hp_bar);
    add_child(mp_bar);
	add_child(hp_text);
    add_child(status_icon_panel);

    // --- Novo método: update() ---
    // Este método sincroniza a UI com os dados atuais do personagem
    static update = function() {
        var _combat = character_instance.combat_info;
        
        // Atualiza os valores das barras
        hp_bar.set_value(_combat.hp);
        mp_bar.set_value(_combat.mp);
        
        // Atualiza o texto de HP
        hp_text.text = "HP: " + string(floor(_combat.hp)) + "/" + string(_combat.hp_max);
        
        // Atualiza os ícones de status
        status_icon_panel.children = []; // Limpa os ícones antigos
        for (var i = 0; i < array_length(_combat.status_effects); i++) {
            var _effect = _combat.status_effects[i];
            // (Vamos adicionar a propriedade 'icon' no próximo passo)
            var icon_element = new UI_Image(0, 0, _effect.icon);
            status_icon_panel.add_child(icon_element);
        }
        
        // Reorganiza os elementos filhos com os novos dados
        update_layout();
    }
}

/// @function UI_CharacterStatusBox(_x, _y, _w, _h, _character)
function UI_CharacterStatusBox(_x, _y, _w, _h, _character) : UI_Panel(_x, _y, _w, _h, "vertical") constructor {
    character = _character;
    spacing = 16;
    padding = 4;
    
    // --- CONSTRUTOR ---
    // Apenas cria os painéis e guarda referências a eles.
    // NENHUMA chamada a update_layout() aqui!
    
    header_panel = new UI_Panel(0, 0, _w, 32, "horizontal");
    hpmp_panel = new UI_Panel(0, 0, _w, 32, "horizontal");
    stat_panel = new UI_Panel(0, 0, _w, 256, "horizontal");
    equip_panel = new UI_Panel(0, 0, _w, 256, "vertical");
	stat_panel_attr = new UI_Panel(0, 0, _w/2, 256, "vertical");
	stat_panel_resist = new UI_Panel(0, 0, _w/2, 256, "vertical");
	
	// Monta a hierarquia principal
    add_child(header_panel);
    add_child(hpmp_panel);
	add_child(stat_panel);
    add_child(equip_panel);
    
    // --- MÉTODO UPDATE ---
    // A responsabilidade dele é apenas ATUALIZAR O CONTEÚDO dos painéis.
    static update = function() {
        if (!is_struct(character)) return;

        var _info = character.character_info;
        var _combat = character.combat_info;
        var _attrs = _combat.attributes_final;
        var _eq = character.equipments;
		var _attrs_list = ["strength", "dexterity", "constitution", "intelligence", "faith", "luck"]
		var _attrs_struct = {
			strength: function() {
			    obj_party_manager_menu.show_tooltip("A Força aumenta o dano de ataques físicos.");
			},
			dexterity: function() {
			    obj_party_manager_menu.show_tooltip("A Destreza aumenta o dano de ataques físicos.");
			},
			constitution: function() {
			    obj_party_manager_menu.show_tooltip( "A Constituição aumenta a vida.");
			},
			intelligence: function() {
			    obj_party_manager_menu.show_tooltip("A Inteligência aumenta o dano de ataques mágicos.");
			},
			faith: function() {
			    obj_party_manager_menu.show_tooltip("A Fé aumenta o dano de ataques mágicos.");
			},
			luck: function() {
			    obj_party_manager_menu.show_tooltip("A Sorte aumenta o dano de ataques críticos.");
			}
		};
		var _resists = _combat.resistances; 
		var _resist_list = ["physic", "magic", "fire", "ice", "poison", "bleeding", "lightning", "dark", "divine"]; 
		var _resist_struct = {
			physic: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra ataques físicos.");
			},
			magic: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra ataques mágicos.");
			},
			fire: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra fogo.");
			},
			ice: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra gelo.");
			},
			poison: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra veneno.");
			},
			bleeding: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra sangramento.");
			},
			lightning: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra raio.");
			},
			dark: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra escuridão.");
			},
			divine: function() {
			    obj_party_manager_menu.show_tooltip("Aumenta a resistência contra divino.");
			}
		};
		
        // Limpa e repopula o conteúdo de cada sub-painel
        
        header_panel.children = [];
        header_panel.add_child(new UI_Text(0, 0, string_upper(_info.name), fnt_ui_main));
        header_panel.add_child(new UI_Text(0, 0, "  Lv " + string(_info.level ?? 1), fnt_ui_main));
        
        hpmp_panel.children = [];
        hpmp_panel.add_child(new UI_Text(0, 0, "HP " + string(floor(_combat.hp)) + "/" + string(_combat.hp_max), fnt_ui_main));
        hpmp_panel.add_child(new UI_Text(0, 0, "  MP " + string(floor(_combat.mp)) + "/" + string(_combat.mp_max), fnt_ui_main));

        stat_panel.children = [];
		stat_panel_attr.children = [];
		stat_panel_resist.children = [];
        for(var i = 0; i < array_length(_attrs_list); i++){
			var stat_panel_line = new UI_Panel(0, 0, header_panel.width, header_panel.height, "horizontal");
			var attr_name = _attrs_list[i];
			var stat = struct_get(_attrs, attr_name);
			var button = new UI_Button(0, 0);
			button.on_hover_enter = struct_get(_attrs_struct, attr_name);
			button.on_hover_leave = function() {
			    obj_character_list_menu.hide_tooltip();
			}
			stat_panel_line.add_child(button);
			array_push(obj_character_list_menu.interactive_elements, button);
			stat_panel_line.add_child(new UI_Text(0, 0, attr_name + ": " + string(stat), fnt_ui_main));
			stat_panel_attr.add_child(stat_panel_line);
		}
		
		stat_panel.add_child(stat_panel_attr);
		
		for(var i = 0; i < array_length(_resist_list); i++){
			var stat_panel_line = new UI_Panel(0, 0, header_panel.width, header_panel.height, "horizontal");
			var resist_name = _resist_list[i];
			var stat = struct_get(_resists, resist_name);
			var button = new UI_Button(0, 0);
			button.on_hover_enter = struct_get(_resist_struct, resist_name);
			button.on_hover_leave = function() {
			    obj_character_list_menu.hide_tooltip();
			}
			stat_panel_line.add_child(button);
			array_push(obj_character_list_menu.interactive_elements, button);
			stat_panel_line.add_child(new UI_Text(0, 0, resist_name + ": " + string(stat), fnt_ui_main));
			stat_panel_resist.add_child(stat_panel_line);
		}
		
		stat_panel.add_child(stat_panel_resist);

        equip_panel.children = [];
		var equipments = struct_get_names(_eq);
        for (var i = 0; i < array_length(equipments); i++) {
			var equipment_names = equipments[i];
			var equipment = struct_get(_eq, equipment_names);
			if(equipment == noone){
				equip_panel.add_child(new UI_Text(0, 0, "Vazio", fnt_ui_main, c_gray));
			}
			else {
				equip_panel.add_child(new UI_Text(0, 0, equipment_names + ": " + string(equipment.name), fnt_ui_main));
			}
		}
    }
    
    // REMOVA o método 'draw' customizado para herdar o do UI_Panel.
}

function UI_CharacterBox(_x, _y, _w, _h, _character) : UI_Panel(_x, _y, _w, _h, "vertical") constructor{
	character = _character;
	width = _w;
    height = _h;
	spacing = 4;
    padding = 8;
	// Habilita o fundo que acabamos de adicionar ao UI_Panel
    background_visible = true;
    background_panel_color = c_dkgray;
	
	header_panel = new UI_Panel(0, 0, _w, 32);
    icon_panel = new UI_Panel(0, 0, _w, 64);
    info_panel = new UI_Panel(0, 0, _w, 32, "horizontal");
	
	header_panel.background_visible = true;
	header_panel.background_panel_color = c_red;
	icon_panel.background_visible = true;
	icon_panel.background_panel_color = c_yellow;
	info_panel.background_visible = true;
	info_panel.background_panel_color = c_orange;
	
	add_child(header_panel);
	add_child(icon_panel);
	add_child(info_panel);

	static update = function(){
		if (!is_struct(character)) return;
		
		var _info = character.character_info;
		//draw_set_halign(fa_center);
		//draw_set_valign(fa_middle);
		header_panel.add_child(new UI_Text(0, 0, _info.name, fnt_ui_description));
		
		icon_panel.add_child(new UI_Image(0, 0, character.sprites.icon));
		
		info_panel.add_child(new UI_Text(0, 0, "Level: " + string(_info.level), fnt_ui_description));
		info_panel.add_child(new UI_Text(0, 0, " " + string(_info.xp) + "/" + string(_info.xp_to_next_level), fnt_ui_description));
		
		draw_set_halign(-1);
		draw_set_valign(-1);
	}
}