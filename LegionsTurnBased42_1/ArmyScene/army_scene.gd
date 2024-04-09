extends Area2D
class_name Army

var destination : Vector2

func _ready():	
	destination = global_position
	pass

func _process(delta):
	var m = (destination - global_position)
	if m.length() > 2:
		global_position += m.normalized()
	pass

func _set_destination(d:Vector2):
	destination = d
	pass


func _on_mouse_entered():
	print("mouse entered army")
	pass
