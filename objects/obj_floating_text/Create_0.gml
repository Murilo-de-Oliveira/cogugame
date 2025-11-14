/// @description Inicializa as variáveis do texto flutuante

text = "";                  // O texto a ser exibido (ex: "120")
color = c_white;            // A cor do texto

duration = 60;              // Duração em frames (60 frames = 1 segundo)
timer = duration;           // Um contador regressivo

move_speed_y = -1;          // Velocidade de subida (negativo para subir)
move_speed_x = random_range(-0.5, 0.5); // Um leve desvio lateral para dar mais vida

alpha = 1;                  // Transparência (1 = opaco, 0 = invisível)
scale = 1.5;                // Escala inicial para um efeito de "POP!"