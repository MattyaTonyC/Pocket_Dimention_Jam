//
var dis = point_distance( x,y, collision_sphere.x,collision_sphere.y )
var dir = point_direction( x,y, collision_sphere.x,collision_sphere.y )

var target_dir = dir + angle_difference( image_angle, dir ) / 100


var target_pos = {
	x: x + lengthdir_x( target_distance, target_dir ),
	y: y + lengthdir_y( target_distance, target_dir ),
}

var travel_dis = point_distance( collision_sphere.x,collision_sphere.y, target_pos.x,target_pos.y ) / 2
var travel_dir = point_direction( collision_sphere.x,collision_sphere.y, target_pos.x,target_pos.y )

var dx = lengthdir_x( travel_dis, travel_dir )
var dy = lengthdir_y( travel_dis, travel_dir )

with (collision_sphere) {
	var collide_list = make_collide_list(nameflags)
	move_and_collide( dx, dy, collide_list )
}
