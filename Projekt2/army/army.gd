extends Node2D
class_name Army

@export var king_code 		= 0
@export var controllable 	= false

var destination : Vector2 

var soldiers = []

func _ready():
	var sl = true;
	for s in get_children():
		#Army first destination
		
		s.army_position = global_position + s.position
		
		## king code
		s.king_code = king_code
		
		## different feets when march...
		s.stepLeft = sl
		sl = not sl
		
		soldiers.append(s)
	pass


func _process(delta):
	
	if controllable and Input.is_action_just_pressed("mouse_left"):
		destination = get_global_mouse_position()
		for s in soldiers:
			s._march_to_destination(s.start_position + destination)
	pass
