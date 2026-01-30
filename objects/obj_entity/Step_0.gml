/// @description Insert description here
// You can write your code in this editor

if mouse_check_button_pressed(mb_left){
	if point_in_rectangle(mouse_x, mouse_y, x, y, x + 32, y + 32){
		is_selected();
	}
}