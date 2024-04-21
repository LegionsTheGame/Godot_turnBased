extends Node2D
class_name MoveingArea

var radius = 120

func _draw():
	draw_arc(Vector2.ZERO,radius,0,2*PI,100,Color.LIME,1)
	draw_arc(Vector2.ZERO,15,0,2*PI,100,Color.LIME,1)
	

func inside(p:Vector2):
	var L = (p-global_position).length()
	#print("in move area",L,L < radius)
	return L < radius
