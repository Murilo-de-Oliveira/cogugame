
if (ui_state == UI_BATTLE_MENU_STATE.MAIN_MENU){
	draw_set_alpha(0.5);
	draw_set_colour(c_black);
	draw_rectangle(
		layout.margin_x, 
		0, 
		layout.menu_width, 
		layout.margin_y, 
		false
	);
	draw_set_colour(-1);
	draw_set_alpha(1);

	draw_set_font(fnt_ui_main);
	var item_margin = layout.item_height;
	var text_margin = 120;
	var _y = 0;
	for (var i = 0; i < array_length(main_menu); i++){
		item_margin = i == main_selected ? (48 * i) : (60 * i);
		text_margin = max(text_margin, 120);
		var color = i == main_selected ? c_navy : c_black;
		_y = 64 * i; 
		draw_rectangle(
			rectangle_layout_normal.x1 + (32 * (min(abs(i - main_selected), 3))), 
			_y + 120, 
			rectangle_layout_normal.x2 + (32 * (min(abs(i - main_selected), 3))), 
			_y + rectangle_layout_normal.item_heigth + 120, 
			false
		);
		draw_text_colour(
			(rectangle_layout_normal.x1 * 1.2) + (32 * (min(abs(i - main_selected), 2))), 
			_y + 120, 
			main_menu[i], 
			color, color, color, color, 
			1
		);
	}
	draw_set_colour(-1);
	draw_set_font(-1);
}

if (ui_state == UI_BATTLE_MENU_STATE.SKILL_MENU){
	draw_set_alpha(0.5);
	draw_set_colour(c_black);
	draw_rectangle(
		0, 
		0, 
		layout.menu_width/2, 
		layout.margin_y, 
		false
	);
	draw_set_colour(-1);
	draw_set_alpha(1);

	for (var i = 0; i < array_length(skill_list); i++){
		var color = i == skill_selected ? c_navy : c_black;
		//draw_set_colour(skill_layout.bg_color);
		draw_skill(skill_list[i], i, color);
	}
	draw_set_colour(-1);
	draw_set_font(-1);
}

if (ui_state == UI_BATTLE_MENU_STATE.TARGET_SELECT){
	draw_set_colour(c_red);
	var _target = targets[target_selected];
	draw_rectangle(
		(_target.x - offset) * x_scale, 
		(_target.y - offset) * y_scale, 
		(_target.x + offset + 32) * x_scale, 
		(_target.y + offset + 32) * y_scale, 
		true
	);
	draw_set_colour(-1);
}



