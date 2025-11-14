/// @description Insert description here
// You can write your code in this editor

//Paineis alinhados

ui_outer_panel = new UI_Panel(room_width/4, room_height/4, (3 * room_width)/4, (3 * room_height)/4, "vertical");

ui_outer_panel.add_child(new UI_Text(0, 0, "Menu Principal", fnt_ui_main));

ui_outer_panel.update();

ui_inner_panel = new UI_Panel(0, 0, 0, 0, "horizontal");

ui_outer_panel.update();

ui_outer_panel.add_child(ui_inner_panel);

ui_inner_panel.add_child(new UI_Text(0, 0, "Opção A", fnt_ui_main));
ui_inner_panel.add_child(new UI_Text(0, 0, "Opção B", fnt_ui_main));
ui_inner_panel.add_child(new UI_Text(0, 0, "Opção C", fnt_ui_main));

ui_outer_panel.update_layout();