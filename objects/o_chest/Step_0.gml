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
if (ejecting) && (cooldown == 0) {
	cooldown = 3
	var dir = point_direction(x,y,o_player.x,o_player.y) + random_range(-45,45)
	drop_pickup( x,y, inventory[ejecting_i].id, 1, dir, 10 )
	inventory[ejecting_i].amount --
	if (inventory[ejecting_i].amount <= 0) inventory[ejecting_i] = new slot_empty()
}
cooldown = max( cooldown-1, 0 )
