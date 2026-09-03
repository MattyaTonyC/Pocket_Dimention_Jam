//
while (image_angle >= 360) image_angle -= 360
while (image_angle < 0) image_angle += 360

hinge = { x:x-lengthdir_x(50,image_angle), y:y-lengthdir_y(50,image_angle) }

collision_spheres = []
for (var i=0; i<3; i++) {
	var sphere = instance_create_layer( hinge.x+lengthdir_x(10+40*i,image_angle), hinge.y+lengthdir_y(10+40*i,image_angle), "Instances", o_sphere )
	with (sphere) {
		target_dis = 10+40*i
		image_xscale = 0.2
		image_yscale = 0.2
		mass = 100
		nameflags = [ "pushable" ]
		image_alpha = 0.25
	}
	array_push( collision_spheres, sphere )
}
