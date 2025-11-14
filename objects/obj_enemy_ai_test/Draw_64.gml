/// @description Insert description here
// You can write your code in this editor

draw_text(0, 0, "Nome: " + enemy.name);
draw_text(0, 20, "Estado: " + string(enemy.state));
draw_text(0, 40, "HP: " + string(enemy.hp));
draw_text(0, 60, "Melhor ação: " + string(enemy.best_action.name));

var list = enemy.action_list;
for (var i = 0; i < array_length(list); i++) {
    draw_text(20, 100 + (20 * i), list[i].name + ": " + string(list[i].priority));
}