/// @description Insert description here
// You can write your code in this editor

var _input = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if (_input != 0) {
    selected_index = clamp(selected_index + _input, 0, array_length(party) - 1);

    ui_current_box.character = party[selected_index];
}
