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
	cooldown = 2
	var dir = point_direction(x,y,o_player.x,o_player.y) + random_range(-45,45)
	with (instance_create_layer( x,y, "Instances", o_pickup )) {
		item_id = other.inventory[other.ejecting_i].id
		var dropped_item_data = struct_get( global.item_list, item_id )
		sprite_index = dropped_item_data.sprite
		spd.x = lengthdir_x(10,dir)
		spd.y = lengthdir_y(10,dir)
	}
	inventory[ejecting_i].amount --
	if (inventory[ejecting_i].amount <= 0) inventory[ejecting_i] = new slot_empty()
}
cooldown = max( cooldown-1, 0 )
