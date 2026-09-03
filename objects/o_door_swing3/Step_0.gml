//
var dir0 = point_direction( hinge.x, hinge.y, collision_spheres[0].x, collision_spheres[0].y )
var dir1 = point_direction( hinge.x, hinge.y, collision_spheres[1].x, collision_spheres[1].y )
var dir2 = point_direction( hinge.x, hinge.y, collision_spheres[2].x, collision_spheres[2].y )
var target_dir = dir0 + angle_difference(dir1,dir0)/3 + angle_difference(dir2,dir0)/3
target_dir += angle_difference( image_angle, target_dir ) / 25

for (var i=0; i<3; i++) {
	var sphere = collision_spheres[i]
	
	var cur_dis = point_distance( hinge.x,hinge.y, sphere.x,sphere.y )
	var cur_dir = point_direction( hinge.x,hinge.y, sphere.x,sphere.y )
	
	var target_pos = {
		x: hinge.x + lengthdir_x( sphere.target_dis, target_dir ),
		y: hinge.y + lengthdir_y( sphere.target_dis, target_dir ),
	}
	
	var travel_dis = point_distance( sphere.x,sphere.y, target_pos.x,target_pos.y )
	var travel_dir = point_direction( sphere.x,sphere.y, target_pos.x,target_pos.y )
	
	var dx = lengthdir_x( travel_dis, travel_dir )
	var dy = lengthdir_y( travel_dis, travel_dir )
	
	with (sphere) {
		var collide_list = make_collide_list(nameflags)
		move_and_collide( dx, dy, collide_list )
	}
}
