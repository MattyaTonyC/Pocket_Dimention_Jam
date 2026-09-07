//
var sprite = s_player_idle
if (spd.x != 0) || (spd.y != 0) sprite = s_player_walk

if (sign(spd.x) != 0) xscale = sign(spd.x)
var xwobble = sign(xscale) * (1 + lengthdir_x(0.05,current_time/10))
var ywobble = (1 - lengthdir_x(0.05,current_time/10))

var image = floor( (sprite_get_speed(sprite)+1) * current_time/1000 * (1+0.5*keyboard_check(vk_shift)) ) mod sprite_get_number(sprite)

//draw_sprite_ext( sprite,image, x,y, xwobble,ywobble, 0, c_white,1 )


/// ПОКУСОЧНАЯ РИСОВКА
// НОГИ
var legs_alpha = 1 - 0.5*anim_water
if (sprite == s_player_idle) draw_sprite_ext( s_player_legs_idle,image, x,y, xwobble,ywobble, 0, c_white,legs_alpha )
else {
	if (anim_input) draw_sprite_ext( s_player_legs_walk,image, x,y, xwobble,ywobble, 0, c_white,legs_alpha )
	else draw_sprite_ext( s_player_legs_break,image, x,y, xwobble,ywobble, 0, c_white,legs_alpha )
}
if (anim_water) draw_sprite_ext( s_player_inwater_effect,0, x,y, xwobble,ywobble, 0, c_white,1 )

// ГОЛОВА ПОД ТЕЛОМ
var head_target_x = 10*sign(xscale)
if (sprite == s_player_idle) head_target_x = 0
head_x_change += (head_target_x - head_x_change) / 10
var head_x = x + head_x_change
var head_y = y + lengthdir_x(2,current_time/10)
if (sprite != s_player_idle) draw_sprite_ext( s_player_head,image, head_x,head_y, xwobble,ywobble, 0, c_white,1 )

// ЗАДНЯЯ РУКА
var backhand_flag = false
var backhand_joint = {x:0,y:0}
if (instance_exists(p_inhand)) if (xscale * p_inhand.image_yscale != 1) {
	var base ={ x:x+xwobble*(backhand_walk_pos[image][0]-50), y:y+ywobble*(backhand_walk_pos[image][1]-50) }
	if (sprite == s_player_idle) base ={ x:x+xwobble*(backhand_idle_pos[0]-50), y:y+ywobble*(backhand_idle_pos[1]-50) }
	var hand ={ x:p_inhand.x, y:p_inhand.y }
	var mid_point = { x:(base.x+hand.x)/2, y:(base.y+hand.y)/2 }
	
	var dis1 = 25
	var dis2 = point_distance( base.x, base.y, hand.x, hand.y ) / 2
	var dis3 = sqrt( sqr(dis1) - sqr(dis2) )
	
	var dir = point_direction( base.x,base.y, hand.x,hand.y ) + 90*xscale
	
	var joint = { x:mid_point.x+lengthdir_x(dis3,dir), y:mid_point.y+lengthdir_y(dis3,dir) }
	backhand_joint = joint
	
	draw_line( base.x, base.y, joint.x, joint.y )
	draw_line( joint.x, joint.y, p_inhand.x, p_inhand.y )
	backhand_flag = true
}
if (!backhand_flag) {
	if (sprite == s_player_idle) draw_sprite_ext( s_player_backhand_idle,image, x,y, xwobble,ywobble, 0, c_white,1 )
	else draw_sprite_ext( s_player_backhand_walk,image, x,y, xwobble,ywobble, 0, c_white,1 )
}

// ТЕЛО
if (sprite == s_player_idle) draw_sprite_ext( s_player_torso_idle,image, x,y, xwobble,ywobble, 0, c_white,1 )
else draw_sprite_ext( s_player_torso_walk,image, x,y, xwobble,ywobble, 0, c_white,1 )

// ГОЛОВА НАД ТЕЛОМ
if (sprite == s_player_idle) draw_sprite_ext( s_player_head,image, head_x,head_y, xwobble,ywobble, 0, c_white,1 )
else {
	if (image >= 4) && (image <= 8) draw_sprite_ext( s_player_head,image, head_x,head_y, xwobble,ywobble, 0, c_white,1 )
}

// ПЕРЕДНЯЯ РУКА
var fronthand_flag = false
if (instance_exists(p_inhand)) if (xscale * p_inhand.image_yscale == 1) {
	var base ={ x:x+xwobble*(fronthand_walk_pos[image][0]-50), y:y+ywobble*(fronthand_walk_pos[image][1]-50) }
	if (sprite == s_player_idle) base ={ x:x+xwobble*(fronthand_idle_pos[0]-50), y:y+ywobble*(fronthand_idle_pos[1]-50) }
	var hand ={ x:p_inhand.x, y:p_inhand.y }
	var mid_point = { x:(base.x+hand.x)/2, y:(base.y+hand.y)/2 }
	
	var dis1 = 27
	var dis2 = point_distance( base.x, base.y, hand.x, hand.y ) / 2
	var dis3 = sqrt( sqr(dis1) - sqr(dis2) )
	
	var dir = point_direction( base.x,base.y, hand.x,hand.y ) - 90*xscale
	
	var joint = { x:mid_point.x+lengthdir_x(dis3,dir), y:mid_point.y+lengthdir_y(dis3,dir) }
	
	draw_line( base.x, base.y, joint.x, joint.y )
	draw_line( joint.x, joint.y, p_inhand.x, p_inhand.y )
	fronthand_flag = true
}
if (!fronthand_flag) {
	if (sprite == s_player_idle) draw_sprite_ext( s_player_fronthand_idle,image, x,y, xwobble,ywobble, 0, c_white,1 )
	else draw_sprite_ext( s_player_fronthand_walk,image, x,y, xwobble,ywobble, 0, c_white,1 )
}

// ЗАДНЯЯ РУКА НАД ТЕЛОМ
if (instance_exists(p_inhand)) if (xscale * p_inhand.image_yscale != 1) {
	draw_line( backhand_joint.x, backhand_joint.y, p_inhand.x, p_inhand.y )
}


//
with (tugging_inst) {
	draw_set_colour(c_aqua); draw_set_alpha(0.5)
	draw_line_width( o_player.x,o_player.y, x,y, 10 )
	draw_set_colour(c_white); draw_set_alpha(1)
}
