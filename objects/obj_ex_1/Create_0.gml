/// @description Insert description here
// You can write your code in this editor

//UI_Panel vertial + UI_Text

ui_panel = new UI_Panel(room_width/4, room_height/4, (3 * room_width)/4, (3 * room_height)/4);
ui_panel.add_child(new UI_Text(0, 0, "Linha 1", fnt_ui_main));
ui_panel.add_child(new UI_Text(0, 0, "Linha 2", fnt_ui_main));
ui_panel.add_child(new UI_Text(0, 0, "Linha 3", fnt_ui_main));