//
with (o_spawner_player) {
	if (entrance_id == global.savedata.entrance_id) {
		instance_create_layer( x,y, "Player", o_player )
		camera.cam_pos.x = x
		camera.cam_pos.y = y
		break
	}
}


