// ВЫДЕЛЕНИЕ
var dis = point_distance( x,y, o_player.x,o_player.y )
if (dis <= 120) circle_alpha = min( circle_alpha+0.05, 0.25)
else circle_alpha = max( circle_alpha-0.025, 0)
draw_set_alpha(circle_alpha)
draw_circle( x,y, 30, false )
draw_set_alpha(1)

// ВОБЛИ СПРАЙТ
var arg = current_time/10+phase_offset
var ang = lengthdir_y(5,2*arg)
var xscale = 1 + lengthdir_x(0.1,arg+45)
var yscale = 1 - lengthdir_x(0.1,arg+45)
var col = make_colour_hsv(0,0,360*(0.75+lengthdir_x(0.25,4*arg)))
var xoff = lengthdir_x(1.5,arg+45)
var yoff = -lengthdir_x(1.5,arg+45)
draw_sprite_ext( sprite_index,0, x-xoff,y-yoff, xscale,yscale, ang, col,1 )

//
if (item_amount > 1) draw_text_transformed( x+10, y+10, item_amount, 0.5,0.5, 0 )
