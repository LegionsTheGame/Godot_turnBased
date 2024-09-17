extends Node2D


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		$SoldierScene.destination = get_global_mouse_position()	
	pass
