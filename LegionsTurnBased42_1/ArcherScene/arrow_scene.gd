extends Area2D
class_name Arrow

var team_number = 0
var destination : Vector2

func _ready():
	#destination = global_position
	pass

func _process(delta):
	var l : Vector2 = destination - global_position
	if l.length() > 2:
		global_position += l.normalized()
		pass
	pass

func _set_destination(d:Vector2):
	destination = d
	pass
