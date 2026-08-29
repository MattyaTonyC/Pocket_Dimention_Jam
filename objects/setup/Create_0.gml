//
instance_create_layer( 0,0, "System", transition )
instance_create_layer( 0,0, "System", cursor )

//
switch (room) {
	
	case (r_menu_main): instance_create_layer( 0,0, "System", menu_main ); break
	
	case (r_game_end): game_end(); break
	
	default:
		instance_create_layer( 0,0, "System", menu_ingame )
		instance_create_layer( 0,0, "System", camera )
		instance_create_layer( 0,0, "System", room_filler )
}

//
global.list_collision.solid = []
array_copy( global.list_collision.solid,0, global.list_collision.solid_temp,0, array_length(global.list_collision.solid_temp) )
array_push( global.list_collision.solid, layer_tilemap_get_id("Walls") )
