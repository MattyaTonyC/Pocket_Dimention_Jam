//
var dir1 = point_direction( x,y, collision_sphere1.x,collision_sphere1.y )
var dir2 = point_direction( x,y, collision_sphere2.x,collision_sphere2.y )
var dir = dir1 + angle_difference( dir2, dir1 ) / 2
draw_sprite_ext( sprite_index, 1, x,y, 1,1, dir, c_white,1 )
