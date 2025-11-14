// Atualiza o painel (se algum filho tiver lógica de update)
ui_test_panel.update();

// Exemplo: diminuir a barra de HP com o tempo
var bar = ui_test_panel.children[4]; // a progress bar que criamos
bar.set_value(bar.current_value - 0.1);
