//
var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()


// ФОН
draw_rectangle_colour( 0,0, gui_w,gui_h, background_col1,background_col2,background_col2,background_col1, false )
draw_set_colour(background_col2)
draw_rectangle( 200, 0, 500, gui_h, false )
draw_set_colour(c_white)


// КНОПКИ МЕНЮ
draw_set_halign(fa_center); draw_set_valign(fa_middle)
for (var i=0; i<array_length(buttons); i++) {
	button_text( 350, gui_h/2 + 48*(i-1), buttons[i] )
}
draw_set_halign(fa_left); draw_set_valign(fa_top)


// НАСТРОЙКИ
if (settings_open) {
	draw_circle( gui_w/2, gui_h/2, gui_h/2, true )
}
