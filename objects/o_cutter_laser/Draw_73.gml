//
if (timer == timer_start) exit

draw_primitive_begin(pr_linestrip)
draw_set_colour(c_maroon)
draw_vertex( x+lengthdir_x(2*timer_start,image_angle+90), y+lengthdir_y(2*timer_start,image_angle+90) )
draw_set_colour(c_red)
draw_vertex( laser_end1.x, laser_end1.y )
draw_set_alpha(0)
if (instance_exists(o_cutter)) draw_vertex( o_cutter.x+lengthdir_x(50,o_cutter.image_angle), o_cutter.y+lengthdir_y(50,o_cutter.image_angle) )
else draw_vertex( o_player.x, o_player.y )
draw_set_alpha(1)
draw_vertex( laser_end2.x, laser_end2.y )
draw_set_colour(c_maroon)
draw_vertex( x+lengthdir_x(2*timer_start,image_angle-90), y+lengthdir_y(2*timer_start,image_angle-90) )
draw_primitive_end()
draw_set_colour(c_white)
