//
background_col1 = make_colour_rgb(250,250,200)
background_col2 = make_colour_rgb(50,100,100)

// КНОПКИ МЕНЮ
buttons = [
	{ text: "New game", func: function(){ transition.target = room_next(room) } },
	{ text: "", func: function(){ menu_main.settings_open = !menu_main.settings_open } },
	{ text: "Exit", func: function(){ transition.target = r_game_end } },
]

//
settings_open = false