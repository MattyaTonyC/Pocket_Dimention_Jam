/// ПЕРЕДВИЖЕНИЕ
var input = { x:0, y:0, dis:0, dir:0 }
with (input) {
	x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	dis = min( point_distance(0,0,x,y), 1 )
	dir = point_direction(0,0,x,y)
}
//
var target_spd = {
	x: (movespd + runspd*keyboard_check(vk_shift)) * lengthdir_x( input.dis, input.dir ),
	y: (movespd + runspd*keyboard_check(vk_shift)) * lengthdir_y( input.dis, input.dir ),
	dis:0, dir:0
}
target_spd.dis = min( point_distance( spd.x, spd.y, target_spd.x, target_spd.y), acc )
target_spd.dir = point_direction( spd.x, spd.y, target_spd.x, target_spd.y)
//
spd.x += lengthdir_x( target_spd.dis, target_spd.dir )
spd.y += lengthdir_y( target_spd.dis, target_spd.dir )

//
var xprev = x
var yprev = y

var collide_list = make_collide_list()

if (array_contains_ext(collide_list,global.list_collision.pushable,true)) push( x+spd.x, y+spd.y, movespd, id )
move_and_collide( spd.x, spd.y, collide_list )

spd.x = sign(spd.x) * min( abs(x-xprev), abs(spd.x) )
spd.y = sign(spd.y) * min( abs(y-yprev), abs(spd.y) )


// ТОЛКАНИЕ ГРУЗОВ
if (!instance_exists(tugging_inst)) {
	if (keyboard_check_pressed(vk_control)) {
		var min_dis = 175
		for (var i=1; i<array_length(global.list_collision.pushable); i++) {
			var inst = instance_nearest( x,y, global.list_collision.pushable[i] )
			if (inst != noone) {
				var inst_dis = point_distance( x,y, inst.x,inst.y )
				if (inst_dis < min_dis) {
					min_dis = inst_dis
					tugging_inst = inst
				}
			}
		}
	}
}
else {
	var current_dis = point_distance( x,y, tugging_inst.x,tugging_inst.y )
	var mouse_dis = point_distance( x,y, mouse_x,mouse_y )
	var target_dis = clamp( current_dis+(mouse_dis-current_dis)/5, 1.5*tugging_inst.sprite_width, 175 )
	
	var current_dir = point_direction( x,y, tugging_inst.x,tugging_inst.y )
	var mouse_dir = point_direction( x,y, mouse_x,mouse_y )
	var target_dir = current_dir + angle_difference( mouse_dir, current_dir ) / 5
	
	var target_pos_x = x + lengthdir_x(target_dis,target_dir)
	var target_pos_y = y + lengthdir_y(target_dis,target_dir)
	var tug_dis = point_distance( tugging_inst.x, tugging_inst.y, target_pos_x, target_pos_y )
	var tug_dir = point_direction( tugging_inst.x, tugging_inst.y, target_pos_x, target_pos_y )
	tugging_inst.spd.x = spd.x + lengthdir_x( tug_dis/2, tug_dir )
	tugging_inst.spd.y = spd.y + lengthdir_y( tug_dis/2, tug_dir )
	var inst_dis = point_distance( x,y, tugging_inst.x,tugging_inst.y )
	if (keyboard_check_pressed(vk_control)) || (inst_dis > 200) tugging_inst = noone
}
