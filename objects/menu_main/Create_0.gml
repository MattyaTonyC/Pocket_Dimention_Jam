//
background_col1 = make_colour_rgb(100,25,50)
background_col2 = make_colour_rgb(25,10,10)

// КНОПКИ МЕНЮ
buttons = [
	{ text: "New game", func: function(){ transition.target = room_next(room) } },
	{ text: "Settings", func: function(){ menu_main.settings_open = !menu_main.settings_open } },
	{ text: "Exit", func: function(){ transition.target = r_game_end } },
]

//
settings_open = false