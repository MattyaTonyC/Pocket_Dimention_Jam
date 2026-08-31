//
timer_start = min( 10000 / point_distance( o_player.x,o_player.y, mouse_x,mouse_y ), 125 )
timer = timer_start
laser_end1 = { x:x+lengthdir_x(2*timer,image_angle+90), y:y+lengthdir_y(2*timer,image_angle+90) }
laser_end2 = { x:x+lengthdir_x(2*timer,image_angle-90), y:y+lengthdir_y(2*timer,image_angle-90) }
