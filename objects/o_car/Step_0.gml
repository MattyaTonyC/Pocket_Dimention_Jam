// ПОСАДКА
if (instance_exists(o_player)) {
	var dis = point_distance( x,y, o_player.x,o_player.y )
	if (dis <= 100) && (keyboard_check_pressed(ord("E"))) {
		var ind = array_get_index(camera.targets,o_player)
		if (ind != -1) array_delete( camera.targets, ind, 1 )
		array_push( camera.targets, id )
		instance_deactivate_object(o_player)
		is_on = true
	}
}
else if (keyboard_check_pressed(ord("E"))) {
	instance_activate_object(o_player)
	var ind = array_get_index(camera.targets,id)
	if (ind != -1) array_delete( camera.targets, ind, 1 )
	array_push( camera.targets, o_player )
	o_player.x = x
	o_player.y = y
	is_on = false
}

//
if (is_on) {
	image_angle += keyboard_check(ord("A")) - keyboard_check(ord("D"))
	x += 5 * lengthdir_x( keyboard_check(ord("W"))-keyboard_check(ord("S")), image_angle )
	y += 5 * lengthdir_y( keyboard_check(ord("W"))-keyboard_check(ord("S")), image_angle )
}

// ДВЕРИ
for (var i=0; i<array_length(doors); i++) {
	var door_x = x + lengthdir_x(25,image_angle) + lengthdir_x(75,image_angle-(1-2*i)*90)
	var door_y = y + lengthdir_y(25,image_angle) + lengthdir_y(75,image_angle-(1-2*i)*90)
	with (doors[i]) {
		x = door_x
		y = door_y
		image_angle = other.image_angle+180
	}
}
