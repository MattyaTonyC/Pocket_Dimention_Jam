//
var sprite = s_player_idle
if (spd.x != 0) || (spd.y != 0) sprite = s_player_walk

if (sign(spd.x) != 0) xscale = sign(spd.x)
var xwobble = sign(xscale) * (1 + lengthdir_x(0.05,current_time/10))
var ywobble = (1 - lengthdir_x(0.05,current_time/10))

var image = floor( (sprite_get_speed(sprite)+1) * current_time/1000 * (1+0.5*keyboard_check(vk_shift)) )

draw_sprite_ext( sprite,image, x,y, xwobble,ywobble, 0, c_white,1 )

//
with (tugging_inst) {
	draw_set_colour(c_aqua); draw_set_alpha(0.5)
	draw_line_width( o_player.x,o_player.y, x,y, 10 )
	draw_set_colour(c_white); draw_set_alpha(1)
}
