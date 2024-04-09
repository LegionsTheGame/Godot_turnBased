extends Node2D
class_name MainScene

var army_list : Array		= []
var selected_army : Army	= null 

func _ready():
	army_list 		= $Armies.get_children()
	selected_army	= army_list[0]
	pass

func _input(event):
	if Input.is_action_just_pressed("mouse_left"):
		selected_army._set_destination(get_global_mouse_position())
		pass
	pass
