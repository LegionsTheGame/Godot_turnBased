extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		$ArmyScene2._march_to(get_global_mouse_position())
	pass
