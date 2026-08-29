// Inherit the parent event
event_inherited();

circle_alpha = 0
phase_offset = random(360)

if (item_id != "") {
	var item_data = struct_get( global.item_list, item_id )
	sprite_index = item_data.sprite
}
item_amount = 1
