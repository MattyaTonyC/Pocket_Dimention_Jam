//
var id_arr = struct_get_names( global.item_list )
for (var i=0; i<array_length(id_arr); i++) {
	with (instance_create_layer( x,y-100*(i+1), "Instances", o_pickup )) {
		item_id = id_arr[i]
		var dropped_item_data = struct_get( global.item_list, item_id )
		sprite_index = dropped_item_data.sprite
	}
}
