//
if (ejecting) {
	while (inventory[ejecting_i].id == noone) {
		ejecting_i ++
		if (ejecting_i == array_length(inventory)) {
			ejecting = false
			ejecting_i = 0
			break
		}
	}
}
if (ejecting) {
	var dir = 45 * round( point_direction(x,y,o_player.x,o_player.y) / 45 ) + random_range(-30,30)
	drop_pickup( x,y, inventory[ejecting_i].id, 1, dir, 10 )
	inventory[ejecting_i].amount --
	if (inventory[ejecting_i].amount <= 0) inventory[ejecting_i] = new slot_empty()
}
