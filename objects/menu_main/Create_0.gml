//
background_col1 = make_colour_rgb(50,50,25)
background_col2 = make_colour_rgb(10,25,10)

// КНОПКИ МЕНЮ
buttons = [
	{ text: "New game", func: function(){ transition.target = room_next(room) } },
	{ text: "Settings", func: function(){ menu_main.settings_open = !menu_main.settings_open } },
	{ text: "Exit", func: function(){ transition.target = r_game_end } },
]

//
settings_open = false