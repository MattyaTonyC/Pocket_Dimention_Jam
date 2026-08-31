//
image_angle = point_direction( o_player.x,o_player.y, mouse_x,mouse_y )

image_yscale = 1
if (image_angle > 90) && (image_angle <= 270) image_yscale = -1

x = o_player.x + lengthdir_x(25,image_angle)
y = o_player.y + lengthdir_y(25,image_angle)
