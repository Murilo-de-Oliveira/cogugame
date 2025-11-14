/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(vk_add)){
	ui_inner_panel.padding++;
	ui_inner_panel.update_layout();
}
else if(keyboard_check_pressed(vk_subtract)){
	ui_inner_panel.padding--;
	ui_inner_panel.update_layout();
}

if(keyboard_check_pressed(vk_up)){
	ui_inner_panel.spacing++;
	ui_inner_panel.update_layout();
}
else if(keyboard_check_pressed(vk_down)){
	ui_inner_panel.spacing--;
	ui_inner_panel.update_layout();
}