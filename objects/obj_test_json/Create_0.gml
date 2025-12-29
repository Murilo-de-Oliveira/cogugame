/// @description Insert description here
// You can write your code in this editor

function load_json_file(_filename){
	show_debug_message(working_directory);
	if (!file_exists(_filename)){
		show_error("CRITICAL: Arquivo " + _filename + " não encontrado!", true);
		return undefined;
	}
	
	var _buffer = buffer_load(_filename);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	try {
		var _json = json_parse(_string);
		show_debug_message("SUCESSO: " + _filename + " carregado");
		return _json;
	} catch (_e) {
		show_error("CRITICAL: JSON corrompido em " + _filename + "\n" + _e.message, true);
        return undefined;
	}
}

show_debug_message("Começamos aqui");

global.Database = {};

var _enemies_raw = load_json_file("enemies_db.json");
show_debug_message(_enemies_raw);

global.Database.Enemies = {};

for (var i = 0; i < array_length(_enemies_raw); i++){
	var _data = _enemies_raw[i];
	global.Database.Enemies[$ _data.id] = _data;
}


show_debug_message(global.Database);
show_debug_message(global.Database.Enemies);