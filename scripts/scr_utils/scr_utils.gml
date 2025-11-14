// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @desc Function Description
function scr_reset_alignment(){
	draw_set_halign(-1);
    draw_set_valign(-1);
	draw_set_color(c_white);
}

/// @function						struct_deep_copy(struct_original);
/// @param {Struct} _original       struct_original O struct a ser copiado.
/// @description					Cria uma cópia profunda de um struct, preservando funções.
/// @return {Struct}				Retorna uma cópia completamente nova e independente.

function struct_deep_copy(_original) {
    if (!is_struct(_original)) return _original;

    var _copy = {};
    var _keys = variable_struct_get_names(_original);

    for (var i = 0; i < array_length(_keys); i++) {
        var _key = _keys[i];
        var _value = variable_struct_get(_original, _key);

        if (is_array(_value)) {
            // Se for um array, copia o array recursivamente
            _copy[$ _key] = array_deep_copy(_value);
        } else if (is_struct(_value)) {
            // Se for um struct, copia o struct recursivamente
            _copy[$ _key] = struct_deep_copy(_value);
        } else {
            // Para valores simples (números, strings, bools, funções), copia diretamente
            _copy[$ _key] = _value;
        }
    }
    return _copy;
}

// Função auxiliar para copiar arrays que possam conter structs
/// @desc Function Description
/// @param {array} _original_array Description
/// @returns {array<Any>} Description
function array_deep_copy(_original_array) {
    var _copy_array = array_create(array_length(_original_array));
    for (var i = 0; i < array_length(_original_array); i++) {
        var _value = _original_array[i];
        if (is_array(_value)) {
            _copy_array[i] = array_deep_copy(_value);
        } else if (is_struct(_value)) {
            _copy_array[i] = struct_deep_copy(_value);
        } else {
            _copy_array[i] = _value;
        }
    }
    return _copy_array;
}

// Em scr_utils.gml ou similar

function scr_apply_health_change(_target, _amount) {
    // Se o alvo já está morto, não faz nada.
    if (_target.combat_info.is_dead) {
        return;
    }

    // 1. Aplica a mudança no HP
	show_debug_message("A mudança no HP foi aplicada");
    _target.combat_info.hp -= _amount;
    
    // 2. Garante que o HP fique nos limites (0 a hp_max)
    _target.combat_info.hp = clamp(_target.combat_info.hp, 0, _target.combat_info.hp_max);
	screenshake(10, 1, 0.4);
    
	// --- INTEGRAÇÃO COM O TEXTO FLUTUANTE ---
    
    // Define o texto e a cor com base no valor
    var _text_to_show = "";
    var _text_color = c_white;
    
    if (_amount > 0) { // Dano
        _text_to_show = string(floor(_amount));
        _text_color = c_orange;
    } else if (_amount < 0) { // Cura
        _text_to_show = string(floor(-_amount)); // Mostra o número positivo
        _text_color = c_lime;
    }
    
    if (_text_to_show != "") {
        // Calcula a posição em pixels a partir da posição no grid
        var _spawn_x = (_target.combat_info.grid_x * 64) + 32; // Centro da célula
        var _spawn_y = (_target.combat_info.grid_y * 64);      // Topo da célula
        
        spawn_floating_text(_spawn_x, _spawn_y, _text_to_show, _text_color);
    }
	
    // 3. VERIFICAÇÃO DE MORTE CENTRALIZADA!
    if (_target.combat_info.hp <= 0) {
        _target.combat_info.is_dead = true;
        show_debug_message("!!! " + _target.character_info.name + " foi derrotado! !!!");
        // Futuramente, aqui você pode:
        // - Mudar o sprite do personagem para um de "caído".
        // - Remover o personagem do grid visualmente.
    }
}

// Em scr_utils.gml ou similar

/// @function               spawn_floating_text(x, y, text, color);
/// @description            Cria uma instância do texto flutuante na posição especificada.
function spawn_floating_text(_x, _y, _text, _color) {
    var _inst = instance_create_layer(_x, _y, "Instances", obj_floating_text);
    
    // Usa 'with' para configurar as variáveis da nova instância
    with (_inst) {
        text = _text;
        color = _color;
    }
    
    return _inst;
}

function scr_string_to_item_id(_item_str)
{
	var _key = string_lower(_item_str);
	
	if variable_struct_exists(global.ItemNameToEnum, _key){
		var _id = global.ItemNameToEnum[$ _key];
		return _id;
	}
	
	return undefined;
}draw_set_halign(fa_left);