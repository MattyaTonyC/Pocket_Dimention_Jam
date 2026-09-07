//
if (hp <= 0) {
	var amount = irandom_range(amount_min,amount_max)
	if (drop_item != "") repeat (amount) {
		var dir = random(360)
		drop_pickup( x,y, drop_item, 1, dir, 5 )
	}
	instance_destroy()
}
