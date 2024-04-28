extends Sprite2D

func _draw():
	if get_parent().teamNumber == 0:
		draw_arc(Vector2.ZERO,get_parent().moveRadius,0,2*PI,100,Color.LIME,3)
	if get_parent().teamNumber == 1:
		draw_arc(Vector2.ZERO,get_parent().moveRadius,0,2*PI,100,Color.RED,3)		
	pass

