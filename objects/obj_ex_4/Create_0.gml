/// @description Insert description here
// You can write your code in this editor

ui_outer_panel = new UI_Panel(room_width/4, room_height/4, (3 * room_width)/4, (3 * room_height)/4, "vertical");

max_value = 100;
panel_angle = 0;
panel_value = 0;
progress_bar = new UI_ProgressBar(0, 0, 500, 100, max_value, c_grey, c_lime);
ui_outer_panel.add_child(progress_bar);

ui_outer_panel.update();