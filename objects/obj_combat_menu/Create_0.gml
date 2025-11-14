width = 64;
height = 104;

op_border = 8; //espaço das letras e da borda
op_space = 16; //espaço entre cada opção

options = ["Ataque", "Habilidade", "Defender", "Mover", "Item", "Fugir"];
movement_options = [];
option_tree = [];
current_menu = options;
menu_title = "Opções";
array_push(option_tree, options);
on_action_selected = noone; // Variável para armazenar a função de callback
skills_list = [];
op_length = array_length(options);
index = 0;
menu_is_active = true;

