
# Mouse indicator


extends Node2D

func _draw():
	#draw_circle(Vector2.ZERO,Globals.mouse_radius,Color.LIGHT_GREEN)
	pass

func _process(delta):
	#global_position =get_global_mouse_position()
	if Input.is_action_just_pressed("mouse_left"):
		$Soldier_mouse._march_to_destination(get_global_mouse_position())
		pass
	pass
