/// @description Insert description here
// You can write your code in this editor

/// @description Anima o texto e o destrói no final

// Move o objeto
x += move_speed_x;
y += move_speed_y;

// Decrementa o timer
timer--;

// Calcula a alpha e a escala com base no tempo restante
// A alpha começa em 1 e vai até 0. A escala começa em 1.5 e vai até 1.
var _life_percent = timer / duration;
alpha = _life_percent;
scale = lerp(1, 1.5, _life_percent); // lerp() interpola suavemente entre dois valores

// Autodestruição
if (timer <= 0) {
    instance_destroy();
}