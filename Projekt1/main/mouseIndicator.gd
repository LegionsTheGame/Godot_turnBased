extends Node2D

func _ready():
	pass


func _draw():
	draw_circle(Vector2.ZERO,Globals.mouse_radius,Color.LIGHT_GREEN)
	pass

func _process(delta):
	global_position = get_global_mouse_position()
	pass
