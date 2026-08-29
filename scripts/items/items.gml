
//
function item_create( arg_sprite, arg_inhand_inst=noone ) constructor {
	sprite = arg_sprite
	inhand_inst = arg_inhand_inst
}


//
item_list = {
	cutter: new item_create( s_item_cutter, o_cutter ),
	log: new item_create( s_item_log ),
	wood: new item_create( s_item_wood ),
	hash: new item_create( s_item_hash ),
	fabric: new item_create( s_item_fabric ),
}
