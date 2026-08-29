//
var dis1 = point_distance( x,y, collision_sphere1.x,collision_sphere1.y )
var dis2 = point_distance( x,y, collision_sphere2.x,collision_sphere2.y )

var dir1 = point_direction( x,y, collision_sphere1.x,collision_sphere1.y )
var dir2 = point_direction( x,y, collision_sphere2.x,collision_sphere2.y )
var target_dir = dir1 + angle_difference( dir2, dir1 ) / 2
target_dir += angle_difference( image_angle, target_dir ) / 100

var target_pos1 = {
	x: x + lengthdir_x( target_distance1, target_dir ),
	y: y + lengthdir_y( target_distance1, target_dir ),
}
var target_pos2 = {
	x: x + lengthdir_x( target_distance2, target_dir ),
	y: y + lengthdir_y( target_distance2, target_dir ),
}

var travel_dis1 = point_distance( collision_sphere1.x,collision_sphere1.y, target_pos1.x,target_pos1.y ) / 4
var travel_dir1 = point_direction( collision_sphere1.x,collision_sphere1.y, target_pos1.x,target_pos1.y )
var travel_dis2 = point_distance( collision_sphere2.x,collision_sphere2.y, target_pos2.x,target_pos2.y ) / 3
var travel_dir2 = point_direction( collision_sphere2.x,collision_sphere2.y, target_pos2.x,target_pos2.y )

var dx1 = lengthdir_x( travel_dis1, travel_dir1 )
var dy1 = lengthdir_y( travel_dis1, travel_dir1 )
var dx2 = lengthdir_x( travel_dis2, travel_dir2 )
var dy2 = lengthdir_y( travel_dis2, travel_dir2 )

with (collision_sphere1) {
	var collide_list = make_collide_list(nameflags)
	move_and_collide( dx1, dy1, collide_list )
}
with (collision_sphere2) {
	var collide_list = make_collide_list(nameflags)
	move_and_collide( dx2, dy2, collide_list )
}
