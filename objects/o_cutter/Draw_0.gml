// Inherit the parent event
event_inherited();

//
if (is_firing) {
	var dir = point_direction( x,y, laser_pos.x,laser_pos.y )
	var laser1 = { x: laser_pos.x+lengthdir_x((50-timer/2),dir-90), y: laser_pos.y+lengthdir_y((50-timer/2),dir-90) }
	var laser2 = { x: laser_pos.x+lengthdir_x((50-timer/2),dir+90), y: laser_pos.y+lengthdir_y((50-timer/2),dir+90) }
	
	image_angle += angle_difference(dir,image_angle) + random_range(-2,2)
	camera.new_screenshake( 1,0.25 )
	
	draw_line( x,y, laser1.x,laser1.y )
	draw_line( x,y, laser2.x,laser2.y )
	
	var dis1 = point_distance( x,y, laser1.x,laser1.y )
	var dir1 = point_direction( x,y, laser1.x,laser1.y )
	draw_sprite_ext( s_laser,0, x,y, dis1/4,1, dir1, c_white,1 )
	
	var dis2 = point_distance( x,y, laser2.x,laser2.y )
	var dir2 = point_direction( x,y, laser2.x,laser2.y )
	draw_sprite_ext( s_laser,0, x,y, dis2/4,1, dir2, c_white,1 )
	
	with (instance_position(laser1.x,laser1.y,p_breakable)) hp --
	with (instance_position(laser2.x,laser2.y,p_breakable)) hp --
	
	timer -= max( point_distance( x,y, laser_pos.x,laser_pos.y) / 200, 0.25 )
	if (timer <= 0) is_firing = false
}
