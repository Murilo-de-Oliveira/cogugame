var pos_x = 32;
var pos_y = 96;

draw_text(32, 80, "Turnos:");

if (current_combatant){
	for (var i = 0; i < array_length(turn_queue); i++){
		draw_text(pos_x, pos_y + (i * 16), string(turn_queue[i].name));
	}
}