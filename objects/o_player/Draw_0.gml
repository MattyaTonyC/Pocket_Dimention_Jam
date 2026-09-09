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
var backhand_base ={ x:x+xwobble*(backhand_walk_pos[image][0]-50), y:y+ywobble*(backhand_walk_pos[image][1]-50) }
if (sprite == s_player_idle) backhand_base ={ x:x+xwobble*(backhand_idle_pos[0]-50), y:y+ywobble*(backhand_idle_pos[1]-50) }
var backhand_joint = {x:0,y:0}
if (instance_exists(p_inhand)) if (xscale * p_inhand.image_yscale != 1) {
	backhand_flag = true
	var base = backhand_base
	
	var base_dis = 0.2 * (50 - point_distance( base.x,base.y, x,y ))
	var item_dir = p_inhand.image_angle
	var t = -1 + 2*min( point_distance( x,y, mouse_x,mouse_y ) / 400, 1 )
	hand = {
		x: x + t*lengthdir_x(base_dis,item_dir),
		y: y + t*lengthdir_y(base_dis,item_dir),
	}
	
	var mid_point = { x:(base.x+hand.x)/2, y:(base.y+hand.y)/2 }
	var mid_dir = point_direction( base.x,base.y, mid_point.x,mid_point.y )
	var dis1 = 25
	var dis2 = point_distance( base.x,base.y, hand.x, hand.y ) / 2
	var dis3 = sqrt(abs( sqr(dis1) - sqr(dis2) ))
	backhand_joint = {
		x: mid_point.x+lengthdir_x(dis3,mid_dir+90*xscale),
		y: mid_point.y+lengthdir_y(dis3,mid_dir+90*xscale),
	}
	draw_sprite_ext( s_player_hand,0, base.x,base.y, 1,-xscale, point_direction(base.x,base.y,backhand_joint.x,backhand_joint.y), c_white,1 )
	draw_sprite_ext( s_player_hand,1, backhand_joint.x,backhand_joint.y, 1,-xscale, point_direction(backhand_joint.x,backhand_joint.y,hand.x,hand.y), c_white,1 )
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
	fronthand_flag = true
	var base ={ x:x+xwobble*(fronthand_walk_pos[image][0]-50), y:y+ywobble*(fronthand_walk_pos[image][1]-50) }
	if (sprite == s_player_idle) base ={ x:x+xwobble*(fronthand_idle_pos[0]-50), y:y+ywobble*(fronthand_idle_pos[1]-50) }
	
	var base_dis = 0.5 * (50 - point_distance( base.x,base.y, x,y ))
	var item_dir = p_inhand.image_angle
	var t = -1 + 2*min( point_distance( x,y, mouse_x,mouse_y ) / 400, 1 )
	hand = {
		x: x + t*lengthdir_x(base_dis,item_dir),
		y: y + t*lengthdir_y(base_dis,item_dir),
	}
	
	var mid_point = { x:(base.x+hand.x)/2, y:(base.y+hand.y)/2 }
	var mid_dir = point_direction( base.x,base.y, mid_point.x,mid_point.y )
	var dis1 = 25
	var dis2 = point_distance( base.x,base.y, hand.x, hand.y ) / 2
	var dis3 = sqrt(abs( sqr(dis1) - sqr(dis2) ))
	var joint = {
		x: mid_point.x+lengthdir_x(dis3,mid_dir-90*xscale),
		y: mid_point.y+lengthdir_y(dis3,mid_dir-90*xscale),
	}
	
	draw_sprite_ext( s_player_hand,0, base.x,base.y, 1,xscale, point_direction(base.x,base.y,joint.x,joint.y), c_white,1 )
	draw_sprite_ext( s_player_hand,1, joint.x,joint.y, 1,xscale, point_direction(joint.x,joint.y,hand.x,hand.y), c_white,1 )
}
if (!fronthand_flag) {
	if (sprite == s_player_idle) draw_sprite_ext( s_player_fronthand_idle,image, x,y, xwobble,ywobble, 0, c_white,1 )
	else draw_sprite_ext( s_player_fronthand_walk,image, x,y, xwobble,ywobble, 0, c_white,1 )
}

// ЗАДНЯЯ РУКА НАД ТЕЛОМ
if (instance_exists(p_inhand)) if (xscale * p_inhand.image_yscale != 1) {
	draw_sprite_ext( s_player_hand,1, backhand_joint.x,backhand_joint.y, 1,-xscale, point_direction(backhand_joint.x,backhand_joint.y,hand.x,hand.y), c_white,1 )
}

//
with (tugging_inst) {
	draw_set_colour(c_aqua); draw_set_alpha(0.5)
	draw_line_width( o_player.x,o_player.y, x,y, 10 )
	draw_set_colour(c_white); draw_set_alpha(1)
}
