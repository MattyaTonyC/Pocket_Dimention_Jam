// Inherit the parent event
event_inherited();

//
if (mouse_check_button_pressed(mb_left)) && (!instance_exists(o_cutter_laser)) {
	with (instance_create_layer( mouse_x,mouse_y, "Instances", o_cutter_laser )) image_angle = other.image_angle
}
