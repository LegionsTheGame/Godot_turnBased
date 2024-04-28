extends Sprite2D

func _draw():
	draw_arc(Vector2.ZERO,get_parent().moveRadius,0,2*PI,100,Color.LIME,3)
	pass

