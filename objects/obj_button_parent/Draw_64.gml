/// @description Insert description here
// You can write your code in this editor

// Draw Event de obj_button_parent

// Calcula o centro do botão
var _centerX = coord.pos_start.x1 + (coord.pos_end.x2 - coord.pos_start.x1) / 2;
var _centerY = coord.pos_start.y1 + (coord.pos_end.y2 - coord.pos_start.y1) / 2;

// Desenha o retângulo do botão
var _rectColor = hover ? c_aqua : c_red;
draw_set_color(_rectColor);
draw_set_alpha(0.5); // Um pouco de transparência
draw_rectangle(coord.pos_start.x1, coord.pos_start.y1, coord.pos_end.x2, coord.pos_end.y2, false);
draw_set_alpha(1.0);

// Desenha o texto centralizado
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(_centerX, _centerY, text);

// Reseta alinhamentos
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white); // Reseta cor