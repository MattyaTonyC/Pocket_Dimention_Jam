//
laser_end1 = { x:x+lengthdir_x(2*timer,image_angle+90), y:y+lengthdir_y(2*timer,image_angle+90) }
laser_end2 = { x:x+lengthdir_x(2*timer,image_angle-90), y:y+lengthdir_y(2*timer,image_angle-90) }

var inst = instance_position( laser_end1.x,laser_end1.y, o_target_practice )
if (inst != noone) inst.hp --
inst = instance_position( laser_end2.x,laser_end2.y, o_target_practice )
if (inst != noone) inst.hp --

timer --
if (timer <= 0) instance_destroy()
