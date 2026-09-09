// Inherit the parent event
event_inherited();

if (!is_firing) timer = min( timer+2, timer_max )
if (mouse_check_button_pressed(mb_left)) && (timer == timer_max) {
	is_firing = true
	laser_pos.x = mouse_x
	laser_pos.y = mouse_y
	timer = timer_max
	
	var dis = point_distance( x,y, laser_pos.x,laser_pos.y )
	if (dis <= 50) is_firing = false
}
if (!mouse_check_button(mb_left)) {
	is_firing = false
}
