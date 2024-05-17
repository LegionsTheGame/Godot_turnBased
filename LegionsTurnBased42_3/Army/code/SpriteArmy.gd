extends Sprite2D

func _draw():	
	var a_helath = 2*PI*get_parent().health/4
	
	if get_parent().teamNumber == 0:
		draw_circle(Vector2.ZERO,get_parent().armyRadius,Color.LIGHT_GREEN)
		draw_arc(Vector2.ZERO,get_parent().armyRadius,0,a_helath,100,Color.DARK_GREEN,6)
	
	if get_parent().teamNumber == 1:
		draw_circle(Vector2.ZERO,get_parent().armyRadius,Color.PINK)
		draw_arc(Vector2.ZERO,get_parent().armyRadius,0,a_helath,100,Color.RED,6)
	
	pass
	

func update_drawing():
	queue_redraw()

