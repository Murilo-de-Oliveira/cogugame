/// @description Insert description here
// You can write your code in this editor

/// @description Desenha o texto com a animação

// Dica profissional: desenhar um contorno preto torna o texto legível em qualquer fundo.
// Fazemos isso desenhando o mesmo texto 4 vezes, deslocado 1 pixel em cada direção.
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_ui_main); // Use a fonte que preferir

var _outline_color = c_black;
draw_text_transformed_color(x + 1, y, text, scale, scale, 0, _outline_color, _outline_color, _outline_color, _outline_color, alpha);
draw_text_transformed_color(x - 1, y, text, scale, scale, 0, _outline_color, _outline_color, _outline_color, _outline_color, alpha);
draw_text_transformed_color(x, y + 1, text, scale, scale, 0, _outline_color, _outline_color, _outline_color, _outline_color, alpha);
draw_text_transformed_color(x, y - 1, text, scale, scale, 0, _outline_color, _outline_color, _outline_color, _outline_color, alpha);

// Agora, desenha o texto principal por cima
draw_text_transformed_color(x, y, text, scale, scale, 0, color, color, color, color, alpha);

// Reseta o alinhamento para não afetar outros objetos
draw_set_halign(fa_left);
draw_set_valign(fa_top);