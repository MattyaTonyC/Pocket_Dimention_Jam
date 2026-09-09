//
var gui_h = display_get_gui_height()

//
draw_set_colour(make_colour_rgb(255,78,76)); draw_set_alpha(0.5)
draw_rectangle( 50, 1/5*gui_h, 100, 4/5*gui_h, true )
draw_rectangle( 50, 1/5*gui_h+3/5*gui_h*timer/timer_max, 100, 4/5*gui_h, false )
if (timer == timer_max) {
	draw_circle( 75, 1/5*gui_h-25, 15, false )
	draw_circle( 75, 4/5*gui_h+25, 15, false )
}
draw_set_colour(c_white); draw_set_alpha(1)
