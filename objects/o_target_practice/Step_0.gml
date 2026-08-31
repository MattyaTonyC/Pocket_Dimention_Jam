//
if (hp <= 0) {
	if (drop_item != "") repeat (amount) {
		var dir = random(360)
		drop_pickup( x+lengthdir_x(50,dir),y+lengthdir_y(50,dir), drop_item, 1, dir, 5 )
	}
	instance_destroy()
}
