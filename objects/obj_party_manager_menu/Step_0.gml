/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(vk_up) { index--; }
else if keyboard_check_pressed(vk_down) { index++; }

index = clamp(index, 0, array_length(character_list) - 1);
