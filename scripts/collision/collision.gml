
//
list_collision = {
	solid: [],
	solid_temp: [ o_wall ],
	
	pushable: [ o_player, p_pushable ],
	
	buildings: [ o_chest ],
	
	destructible: [ o_target_practice ],
}
list_collision_all_nameflags = [ "solid", "pushable", "buildings", "destructible" ]

//
function make_collide_list( nameflags=global.list_collision_all_nameflags ) {
	var collide_list = []
	for (var i=0; i<array_length(nameflags); i++) {
		var collision_type_list = struct_get( global.list_collision, nameflags[i] )
		if (!place_meeting(x,y,collision_type_list)) array_copy( collide_list, array_length(collide_list), collision_type_list, 0, array_length(collision_type_list) )
		else if (random(100) < 10) {
			spd.x += random_range(-2,2)
			spd.y += random_range(-2,2)
			audio_play_sound( snd_Gmod_Collision, 0,false, random_range(0.5,0.75), 0, random_range(0.5,1.5) )
		}
	}
	return collide_list
}

//
function push( x0,y0, push_dis, caller_id=id ) {
	if (push_dis < 0.1) return
	
	var collision_list = ds_list_create()
	var collision_num = instance_place_list( x0,y0, global.list_collision.pushable, collision_list, true )
	
	for (var i=0; i<collision_num; i++) {
		if (collision_list[|i].id == caller_id) continue
		
		with (collision_list[|i]) {
			var push_dir = point_direction( other.x,other.y, x,y )
			if (object_index == o_cube) push_dir = 90*round(push_dir/90)
			
			var k = other.mass / mass / 2
			var dx = lengthdir_x( k*push_dis, push_dir )
			var dy = lengthdir_y( k*push_dis, push_dir )
			
			//
			var temp_nameflags = global.list_collision_all_nameflags
			if (variable_instance_exists(id,"nameflags")) temp_nameflags = nameflags
			var collide_list = make_collide_list(temp_nameflags)
			if (array_contains(temp_nameflags,"pushable")) push( x+dx, y+dy, k*push_dis, other.id )
			move_and_collide( dx, dy, collide_list )
			
			spd.x = k*dx
			spd.y = k*dy
		}
	}
	ds_list_destroy(collision_list)
}
