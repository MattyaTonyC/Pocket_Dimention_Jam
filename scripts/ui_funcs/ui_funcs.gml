
//
function button_text( x0, y0, struct={} ) {
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	var text = "text button"
	if (struct_exists(struct,"text")) text = struct.text
	
	var size = 1
	if (struct_exists(struct,"size")) size = struct.size
	var w = size * string_width(text)
	var h = size * string_height(text)
	var rx = x0 - w/2 * draw_get_halign()
	var ry = y0 - h/2 * draw_get_valign()
	var inside = point_in_rectangle( mx,my, rx, ry, rx+w, ry+h )
	var click = mouse_check_button_pressed(mb_left)
	
	var col = c_gray
	if (struct_exists(struct,"col_out")) col = struct.col_out
	if (inside) {
		col = c_white
		if (struct_exists(struct,"col_in")) col = struct.col_in
	}
	draw_set_colour(col)
	draw_text_transformed( x0,y0, text, size,size, 0 )
	draw_set_colour(c_white)
	
	if (struct_exists(struct,"func")) && (inside && click) {
		var arg = noone
		if (struct_exists(struct,"arg")) arg = struct.arg
		struct.func(arg)
	}
}
