/// @description Insert description here
// You can write your code in this editor

// Painel horizontal
ui_panel = new UI_Panel(room_width/4, room_height/4, (3 * room_width)/4, (3 * room_height)/4, "vertical");

ui_panel.add_child(new UI_Text(0, 0, "A", fnt_ui_main));
ui_panel.add_child(new UI_Text(0, 0, "B", fnt_ui_main));
ui_panel.add_child(new UI_Text(0, 0, "C", fnt_ui_main));
