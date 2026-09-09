//
is_on = false

//
doors = []

// ЛЕВАЯ ДВЕРЬ
var door_x = x + lengthdir_x(25,image_angle) + lengthdir_x(75,image_angle-90)
var door_y = y + lengthdir_y(25,image_angle) + lengthdir_y(75,image_angle-90)
var inst = instance_create_layer( door_x,door_y, "Instances", o_door_swing3 )
with (inst) {
	image_angle = other.image_angle - 180
}
array_push( doors, inst )

// ПРАВАЯ ДВЕРЬ
door_x = x + lengthdir_x(25,image_angle) + lengthdir_x(75,image_angle+90)
door_y = y + lengthdir_y(25,image_angle) + lengthdir_y(75,image_angle+90)
inst = instance_create_layer( door_x,door_y, "Instances", o_door_swing3 )
with (inst) {
	image_angle = other.image_angle - 180
}
array_push( doors, inst )
