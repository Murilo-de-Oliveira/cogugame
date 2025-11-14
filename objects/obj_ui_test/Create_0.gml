// Painel raiz
ui_test_panel = new UI_Panel(50, 50, 0, 0, "vertical");

// Teste 1: textos simples
var txt1 = new UI_Text(0, 0, "Linha 1", fnt_ui_main, c_white);
var txt2 = new UI_Text(0, 0, "Linha 2", fnt_ui_main, c_aqua);
var txt3 = new UI_Text(0, 0, "Linha 3", fnt_ui_main, c_red);

// Adiciona ao painel
ui_test_panel.add_child(txt1);
ui_test_panel.add_child(txt2);
ui_test_panel.add_child(txt3);

// Teste 2: painel horizontal dentro do vertical
var h_panel = new UI_Panel(0, 0, 0, 0, "horizontal");
h_panel.add_child(new UI_Text(0, 0, "A", fnt_ui_main, c_yellow));
h_panel.add_child(new UI_Text(0, 0, "B", fnt_ui_main, c_orange));
h_panel.add_child(new UI_Text(0, 0, "C", fnt_ui_main, c_green));

ui_test_panel.add_child(h_panel);

// Teste 3: barra de progresso
var hp_bar = new UI_ProgressBar(0, 0, 100, 16, 100, c_dkgray, c_lime);
hp_bar.set_value(75); // começa em 75%

ui_test_panel.add_child(hp_bar);
