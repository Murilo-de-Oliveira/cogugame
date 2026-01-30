draw_battle_ui();

function draw_battle_ui() {
	
	draw_menu_box();
	
	switch(ui_state) {
		case UI_BATTLE_MENU_STATE.MAIN_MENU:
			draw_vertical_menu(main_menu, main_selected);
			break;
			
		case UI_BATTLE_MENU_STATE.SKILL_MENU:
			draw_skill_menu();
			break;
			
		case UI_BATTLE_MENU_STATE.TARGET_SELECT:
			draw_target_cursor();
			draw_enemy_desc();
			break;
	}
}

function draw_menu_box() {

    var x1 = layout.margin_x;
    var y1 = layout.margin_y;
    var x2 = x1 + layout.menu_width;
    var y2 = y1 + 180;

    draw_rectangle(x1, y1, x2, y2, true);
}

function draw_vertical_menu(_items, _selected) {

    for (var i = 0; i < array_length(_items); i++) {
        var yy = layout.margin_y + i * layout.item_height;

        draw_set_color(i == _selected ? c_yellow : c_white);
        draw_text(layout.margin_x + 8, yy, _items[i]);
    }
}

function draw_skill_menu() {

    draw_vertical_menu(
        array_map(skill_list, function(s) { return s.name; }),
        skill_selected
    );

    var skill = skill_list[skill_selected];
    draw_text(400, layout.margin_y, skill.desc);
}

function draw_target_cursor() {
    var target = targets[target_selected];
	draw_set_colour(c_red);
    //draw_rectangle(
	//	target.x * x_scale, 
	//	target.y * y_scale, 
	//	(target.x + 32) * x_scale, 
	//	(target.y + 32) * y_scale, 
	//	true
	//);
	draw_circle(
		(target.x + 16) * x_scale, 
		(target.y + 16) * y_scale,
		64,
		true
	);
}

function draw_enemy_desc(){
	var target = targets[target_selected];
	
	var x1 = layout.margin_x + layout.menu_width;
    var y1 = layout.margin_y;
    var x2 = display_get_gui_width() * 0.97;
    var y2 = y1 + 180;
	
	draw_set_colour(-1);
	
	draw_sprite_ext(spr_char_icon_base, 0, x1 + 32, y1 + 16, 4, 4, 0, c_white, 1);
	target.show_status(x1 + 160, y1 + 16);

	draw_rectangle(x1, y1, x2, y2, true);
}

draw_set_font(-1);
draw_set_colour(-1);

