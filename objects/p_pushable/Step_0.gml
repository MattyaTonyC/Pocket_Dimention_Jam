//
var target_spd = {
	dis: min( point_distance( spd.x,spd.y, 0,0 ), acc ),
	dir: point_direction( spd.x,spd.y, 0,0 ),
}

spd.x += lengthdir_x( target_spd.dis, target_spd.dir )
spd.y += lengthdir_y( target_spd.dis, target_spd.dir )

//
var xprev = x
var yprev = y

var collide_list = make_collide_list(nameflags)

if (array_contains_ext(collide_list,global.list_collision.pushable,true)) {
	var push_dis = point_distance( 0,0, spd.x,spd.y )
	push( x+spd.x, y+spd.y, push_dis, id )
}
move_and_collide( spd.x, spd.y, collide_list )

spd.x = sign(spd.x) * min( abs(x-xprev), abs(spd.x) )
spd.y = sign(spd.y) * min( abs(y-yprev), abs(spd.y) )
