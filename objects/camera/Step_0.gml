// СЛЕДОВАНИЕ ЗА ЦЕЛЯМИ
var target_pos = { x:0, y:0, dis:0, dir:0 }
var targets_count = 0

for (var i=0; i<array_length(targets); i++) {
	with (targets[i]) {
		target_pos.x += x
		target_pos.y += y
		targets_count += 1
	}
}
target_pos.x /= targets_count
target_pos.y /= targets_count
target_pos.dis = point_distance( cam_pos.x, cam_pos.y, target_pos.x, target_pos.y )
target_pos.dir = point_direction( cam_pos.x, cam_pos.y, target_pos.x, target_pos.y )
cam_pos.x += lengthdir_x( target_pos.dis, target_pos.dir ) / smoothness
cam_pos.y += lengthdir_y( target_pos.dis, target_pos.dir ) / smoothness


// РАЗМЕР
if (mouse_check_button_pressed(mb_middle)) size_target = 1
if (!keyboard_check(vk_alt)) size_target += size_step * (mouse_wheel_down() - mouse_wheel_up())
size += (size_target - size) / size_smoothness
size_target = clamp( size_target, 0.5, 2 )
camera_set_view_size( cam_id, w*size, h*size )


// ВЛИЯНИЕ МЫШИ
if (mouse_influence) {
	var mx = device_mouse_x_to_gui(0) / display_get_gui_width() - 0.5
	var my = device_mouse_y_to_gui(0) / display_get_gui_height() - 0.5
	mouse_pos.x += (w*mx*mouse_strength - mouse_pos.x) / mouse_smoothness
	mouse_pos.y += (h*my*mouse_strength - mouse_pos.y) / mouse_smoothness
}


// ТРЯСКА
var screenshake = { x:0, y:0 }
var arg = current_time
for (var i=0; i<array_length(shake_list); i++) {
	var shake = shake_list[i]
	
	with (shake) {
		var polarized_dis = lengthdir_x( strength, arg*intensity )
		var unpolarized_dis = lengthdir_y( polarization*strength, arg*intensity )
		screenshake.x += lengthdir_x( polarized_dis, dir ) + lengthdir_x( unpolarized_dis, dir+90 )
		screenshake.y += lengthdir_y( polarized_dis, dir ) + lengthdir_y( unpolarized_dis, dir+90 )
	
		strength *= strength_fade
		intensity *= intensity_fade
		if (strength <= 0.1) {
			array_delete( other.shake_list, i, 1 )
			i--
		}
	}
}


//
x = cam_pos.x + size * (mouse_pos.x + screenshake.x)
y = cam_pos.y + size * (mouse_pos.y + screenshake.y)
camera_set_view_pos( cam_id, x - w/2*size, y - h/2*size )