
//
function item_create( arg_sprite, arg_inhand_inst=noone ) constructor {
	sprite = arg_sprite
	inhand_inst = arg_inhand_inst
}


//
item_list = {
	// fish
	fish_stock: new item_create( s_item_fish_stock ),
	fish_hash: new item_create( s_item_fish_hash ),
	fish_peeper: new item_create( s_item_fish_peeper ),
	fish_reaper: new item_create( s_item_fish_reaper ),
	
	// instruments
	cutter: new item_create( s_item_cutter, o_cutter ),
	fishing_rod: new item_create( s_item_fishing_rod, o_fishing_rod ),
	
	// materials
	log: new item_create( s_item_log ),
	wood: new item_create( s_item_wood ),
	hash: new item_create( s_item_hash ),
	fabric: new item_create( s_item_fabric ),
	stone: new item_create( s_item_stone ),
	
	// misc
	red_triangle: new item_create( s_item_red_triangle ),
	red_conlang: new item_create( s_item_conlang ),
	red_pain_dough: new item_create( s_item_pain_dough ),
}
