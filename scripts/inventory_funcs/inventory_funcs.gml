
//
list_inventory = [ o_chest ]


// СЛОТЫ
function slot_empty() constructor  {
	id = noone
	amount = 0
}
//
function slot_item( arg_id, arg_amount ) constructor  {
	id = arg_id
	amount = arg_amount
}


// СОЗДАНИЕ
function inventory_create_empty( size ) {
	var inv = []
	repeat (size) array_push( inv, new slot_empty() )
	return inv
}


// ОТОБРАЖЕНИЕ
function inventory_draw( x0,y0, inv, inhand=noone ) {
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	var hover_i = noone
	var s = 75
	for (var i=0; i<array_length(inv); i++) {
		var ix = x0 + 100*(i+0.5-array_length(inv)/2)
		draw_rectangle( ix-s/2, y0-s/2, ix+s/2, y0+s/2, true )
		
		if (i == inhand) {
			draw_set_colour(c_yellow)
			draw_line( ix-s/2, y0-s/2-5, ix+s/2, y0-s/2-5 )
			draw_set_colour(c_white)
		}
		
		var item = inv[i]
		if (item.id != noone) {
			var item_data = struct_get( global.item_list, item.id )
			draw_sprite( item_data.sprite, 0, ix, y0 )
			
			draw_set_halign(fa_right); draw_set_valign(fa_bottom)
			draw_text_transformed( ix+s/2 -2, y0+s/2 +1, item.amount, 0.5,0.5, 0 )
			draw_set_halign(fa_left); draw_set_valign(fa_top)
		}
		
		var inside = point_in_rectangle( mx,my, ix-s/2, y0-s/2, ix+s/2, y0+s/2 )
		if (inside) hover_i = i
	}
	return hover_i
}


// ВЗАИМОДЕЙСТВИЕ
function inventory_add( inv, item ) {
	var target_slot = noone
	for (var i=0; i<array_length(inv); i++) {
		if (target_slot == noone) && (inv[i].id == noone) target_slot = i
		if (inv[i].id == item.id) {
			target_slot = i
			break
		}
	}
	if (target_slot != noone) {
		inv[target_slot].id = item.id
		inv[target_slot].amount += item.amount
	}
	return target_slot
}
