//
var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

// МЕНЮ ПАУЗЫ
if (pause_menu) {
	// ФОН
	draw_set_colour(c_black); draw_set_alpha(0.5)
	draw_rectangle( 0,0, gui_w,gui_h, false )
	draw_set_alpha(0.75)
	draw_rectangle( 200, 0, 500, gui_h, false )
	draw_set_colour(c_white); draw_set_alpha(1)
	
	// КНОПКИ
	draw_set_halign(fa_center); draw_set_valign(fa_middle)
	for (var i=0; i<array_length(buttons); i++) {
		button_text( 350, gui_h/2+48*(i-1), buttons[i] )
	}
	draw_set_halign(fa_left); draw_set_valign(fa_top)
	
	// НАСТРОЙКИ
	if (settings_open) {
		draw_circle( gui_w/2, gui_h/2, gui_h/2, true )
	}
}


// В ИГРЕ (ВНЕ ПАУЗЫ)
else {
	// ВЫБОР ПРЕДМЕТА В РУКАХ
	var inhand_slot_target = noone
	for (var i=0; i<=9; i++) {
		if (keyboard_check_pressed(ord(string(i)))) {
			inhand_slot_target = i - 1
			if (i==0) inhand_slot_target = 9
		}
	}
	if (inhand_slot_target != noone) {
		if (inhand_slot != inhand_slot_target) inhand_slot = inhand_slot_target
		else inhand_slot = noone
	}
	if (keyboard_check(vk_alt)) {
		var wheel_change = mouse_wheel_up() - mouse_wheel_down()
		if (wheel_change != 0) {
			if (inhand_slot == noone) inhand_slot = -1
			inhand_slot += mouse_wheel_up() - mouse_wheel_down()
			if (inhand_slot > 9) inhand_slot = 0
			if (inhand_slot < 0) inhand_slot = 9
		}
	}
	
	// ЭКЗЕМПЛЯР ПРЕДМЕТА В РУКАХ
	var inhand_inst_target = noone
	var inhand_item_data = {}
	if (inhand_slot != noone) {
		var inhand_item = o_player.inventory[inhand_slot]
		if (inhand_item.id != noone) {
			inhand_item_data = struct_get( global.item_list, inhand_item.id )
			if (struct_exists(inhand_item_data,"inhand_inst")) inhand_inst_target = inhand_item_data.inhand_inst
		}
	}
	
	if (inhand_inst != noone) {
		if (inhand_inst.object_index != inhand_inst_target) {
			instance_destroy(inhand_inst)
			inhand_inst = noone
			if (inhand_inst_target != noone) inhand_inst = instance_create_layer( o_player.x,o_player.y, "Player", inhand_inst_target )
		}
	}
	else if (inhand_inst_target != noone) inhand_inst = instance_create_layer( o_player.x,o_player.y, "Player", inhand_inst_target )
	
	
	// ОТРИСОВКА ИНВЕНТОРЕЙ
	var hover_inv = o_player.inventory
	var hover_i = inventory_draw( gui_w/2, gui_h-50, o_player.inventory, inhand_slot )
	
	var inv_inst = noone
	var min_dis = 150
	for (var i=0; i<array_length(global.list_inventory); i++) {
		var inst = instance_nearest( o_player.x,o_player.y, global.list_inventory[i] )
		if (inst != noone) {
			var dis = point_distance( o_player.x,o_player.y, inst.x,inst.y )
			if (dis < min_dis) {
				min_dis = dis
				inv_inst = inst
			}
		}
	}
	if (inv_inst != noone) {
		var temp_hover_i = inventory_draw( gui_w/2, gui_h-150, inv_inst.inventory )
		if (hover_i == noone) {
			hover_i = temp_hover_i
			hover_inv = inv_inst.inventory
		}
		
		var eject_button = { text:"Eject All", func:function(inst){inst.ejecting = true}, arg:inv_inst }
		button_text( gui_w/2+50*array_length(inv_inst.inventory), gui_h-150-25, eject_button )
	}
	
	// ПРЕДМЕТ В МЫШКЕ
	if (hover_i != noone) && (inhand_inst == noone) && (mouse_check_button_pressed(mb_left)) {
		drag_slot = hover_inv[hover_i]
		hover_inv[hover_i] = new slot_empty()
		drag_slot_i = hover_i
		drag_slot_inv = hover_inv
	}
	if (drag_slot.id != noone) {
		var item_data = struct_get( global.item_list, drag_slot.id )
		draw_sprite( item_data.sprite, 0, mx,my )
		
		var s = 75
		draw_set_halign(fa_right); draw_set_valign(fa_bottom)
		draw_text_transformed( mx+s/2 -1, my+s/2 +1, drag_slot.amount, 0.5,0.5, 0 )
		draw_set_halign(fa_left); draw_set_valign(fa_top)
		
		//
		if (mouse_check_button_released(mb_left)) {
			var target_i = hover_i
			var target_inv = hover_inv
			if (hover_i == noone) {
				target_i = drag_slot_i
				target_inv = drag_slot_inv
			}
			
			switch (target_inv[target_i].id) {
				case (noone):
				case (drag_slot.id):
					target_inv[target_i].id = drag_slot.id
					target_inv[target_i].amount += drag_slot.amount
					break
				default:
					var temp = target_inv[target_i]
					target_inv[target_i] = drag_slot
					drag_slot_inv[drag_slot_i] = temp
			}
			drag_slot = new slot_empty()
		}
	}
	if (drag_slot.id != noone) {
		if (mouse_check_button_released(mb_right)) {
			var target_i = hover_i
			var target_inv = hover_inv
			if (hover_i == noone) {
				target_i = drag_slot_i
				target_inv = drag_slot_inv
			}
			
			if (hover_i == noone) {
				var dir = point_direction( o_player.x, o_player.y, mouse_x, mouse_y ) 
				with (instance_create_layer( o_player.x,o_player.y, "Instances", o_pickup )) {
					item_id = other.drag_slot.id
					var dropped_item_data = struct_get( global.item_list, item_id )
					sprite_index = dropped_item_data.sprite
					spd.x = lengthdir_x(10,dir)
					spd.y = lengthdir_y(10,dir)
				}
				drag_slot.amount --
				if (drag_slot.amount <= 0) drag_slot = new slot_empty()
			}
			else if (hover_inv[hover_i].id == drag_slot.id) {
				
			}
		}
	}
}

// ПАУЗА
if (keyboard_check_pressed(vk_escape)) pause_menu = !pause_menu
if (pause_menu) && (!pause_menu_prev) {
	instance_deactivate_object(camera)
	instance_deactivate_layer("Player")
	instance_deactivate_layer("Instances")
	view_set_visible(0,false)
}
if (!pause_menu) && (pause_menu_prev) {
	instance_activate_object(camera)
	instance_activate_layer("Player")
	instance_activate_layer("Instances")
	view_set_visible(0,true)
}
pause_menu_prev = pause_menu
