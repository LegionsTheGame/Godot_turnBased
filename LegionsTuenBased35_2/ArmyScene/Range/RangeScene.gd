extends Area2D

class_name RangeScene

var radius : int 	= 126

func _ready():
	pass

func _is_inside(position:Vector2):
	var v = global_position - position
	if v.length() < radius:
		return true 
	pass
