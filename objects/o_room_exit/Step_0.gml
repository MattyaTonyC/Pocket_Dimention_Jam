//
if (place_meeting( x,y, o_player )) {
	transition.target = target_room
	global.savedata.room = target_room
	global.savedata.entrance_id = entrance_id
}
