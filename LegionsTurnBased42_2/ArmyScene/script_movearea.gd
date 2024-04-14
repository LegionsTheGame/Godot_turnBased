extends Node2D

var radius = 120

func _draw():
	draw_arc(Vector2.ZERO,radius,0,2*PI,100,Color.LIME,3)

func inside(p:Vector2):
	var L = (p-global_position).length()
	print(str(L), " L er stor nok til move")
	return L < radius and L > 20
