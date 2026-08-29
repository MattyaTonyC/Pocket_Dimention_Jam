//
collision_sphere = instance_create_layer( x,y, "Instances", o_sphere )

target_distance = 75

with (collision_sphere) {
	x += lengthdir_x( other.target_distance, other.image_angle )
	y += lengthdir_y( other.target_distance, other.image_angle )
	image_xscale = 0.25
	image_yscale = 0.25
	mass = 150
	nameflags = [ "pushable" ]
}
