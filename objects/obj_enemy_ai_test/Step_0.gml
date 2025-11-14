/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_enter)) enemy.hp++;
if (keyboard_check_pressed(vk_backspace)) enemy.hp--;
if (keyboard_check_pressed(ord("C"))) {
    enemy.calculate_priority();
    enemy.choose_best_action();
}
if (keyboard_check_pressed(ord("R"))) {
	enemy.reset_priority();
}
enemy.change_state()
