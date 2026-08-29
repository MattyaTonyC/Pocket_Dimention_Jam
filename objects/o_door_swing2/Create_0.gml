//
collision_sphere1 = instance_create_layer( x,y, "Instances", o_sphere )
collision_sphere2 = instance_create_layer( x,y, "Instances", o_sphere )

target_distance1 = 55
target_distance2 = 90

while (image_angle >= 360) image_angle -= 360
while (image_angle < 0) image_angle += 360

with (collision_sphere1) {
	x += lengthdir_x( other.target_distance1, other.image_angle )
	y += lengthdir_y( other.target_distance1, other.image_angle )
	image_xscale = 0.2
	image_yscale = 0.2
	mass = 110
	nameflags = [ "pushable" ]
}
with (collision_sphere2) {
	x += lengthdir_x( other.target_distance2, other.image_angle )
	y += lengthdir_y( other.target_distance2, other.image_angle )
	image_xscale = 0.15
	image_yscale = 0.15
	mass = 100
	nameflags = [ "pushable" ]
}
