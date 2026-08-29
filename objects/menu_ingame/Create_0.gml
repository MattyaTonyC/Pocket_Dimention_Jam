//
pause_menu = false
pause_menu_prev = false
buttons = [
	{ text: "Return", func: function(){ menu_ingame.pause_menu = false } },
	{ text: "Settings", func: function(){ menu_ingame.settings_open = !menu_ingame.settings_open } },
	{ text: "Exit", func: function(){ transition.target = r_menu_main } },
]

//
settings_open = false

//
inhand_slot = noone
inhand_inst = noone

//
drag_slot = new slot_empty()
drag_slot_i = noone
drag_slot_inv = noone
