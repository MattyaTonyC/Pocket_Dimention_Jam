// Inherit the parent event
event_inherited();

// СОЕДИНЕНИЕ ПИКАПОВ
var inst = instance_place(x,y,o_pickup)
if (inst != noone) if (inst.item_id == item_id) {
	item_amount += inst.item_amount
	with (inst) instance_destroy()
}

// ПОДБОР
if (keyboard_check(vk_space)) && (item_id != "") {
	var dis = point_distance( x,y, o_player.x,o_player.y )
	if (dis <= 120) {
		var success = inventory_add( o_player.inventory, { id:item_id, amount:item_amount } )
		if (success != noone) instance_destroy()
	}
}
