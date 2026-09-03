//
var dir0 = point_direction( hinge.x, hinge.y, collision_spheres[0].x, collision_spheres[0].y )
var dir1 = point_direction( hinge.x, hinge.y, collision_spheres[1].x, collision_spheres[1].y )
var dir2 = point_direction( hinge.x, hinge.y, collision_spheres[2].x, collision_spheres[2].y )
var dir = dir0 + angle_difference(dir1,dir0)/3 + angle_difference(dir2,dir0)/3
draw_sprite_ext( sprite_index, 1, hinge.x+lengthdir_x(50,dir),hinge.y+lengthdir_y(50,dir), 1,1, dir, c_white,1 )
