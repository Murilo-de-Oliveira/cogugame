/// @description Insert description here
// You can write your code in this editor

panel_value++;
panel_angle = abs(sin(degtorad(panel_value)));
progress_bar.set_value(max_value * panel_angle);
ui_outer_panel.update_layout();
	
if panel_value >= 360{
	panel_value = 0;
} 