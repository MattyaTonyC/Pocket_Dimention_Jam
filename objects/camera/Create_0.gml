//
cam_id = view_camera[0]
w = 1920
h = 1080

// СЛЕДОВАНИЕ ЗА ЦЕЛЯМИ
targets = [o_player]
cam_pos = { x:0, y:0 }
smoothness = 10

// РАЗМЕР
size_target = 1
size = 1
size_step = 0.1
size_smoothness = 10

// ВЛИЯНИЕ МЫШИ
mouse_influence = true
mouse_pos = { x:0, y:0 }
mouse_strength = 1/3
mouse_smoothness = 3

// ТРЯСКА
shake_list = []
function new_screenshake( strength, strength_fade, polarization=1, dir=0, intensity=10, intensity_fade=strength_fade) {
	array_push( shake_list, {
		strength: strength, strength_fade: strength_fade,
		polarization: polarization, dir: dir,
		intensity: intensity, intensity_fade: intensity_fade,
	})
}
