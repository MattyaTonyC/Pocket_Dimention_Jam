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
if (tugging_inst == noone) {
	if (keyboard_check_pressed(vk_control)) {
		var min_dis = 150
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
	tugging_inst.spd.x = spd.x
	tugging_inst.spd.y = spd.y
	var inst_dis = point_distance( x,y, tugging_inst.x,tugging_inst.y )
	if (keyboard_check_released(vk_control)) || (inst_dis > 200) tugging_inst = noone
}
