extends Node2D
class_name Army

@export var king_code 		= 0
@export var controllable 	= false

var destination : Vector2 

var soldiers = []

func _ready():
	print("army ready")
	var sl = true;
	
	for s in get_children():
		
		#Soldiers first army-destination
		#s.army_position = global_position + s.position
		
		##Soldiers king code - given from army
		s.king_code = king_code
		
		##Soldiers - use different feets when marching...
		s.stepLeft = sl
		sl = not sl
		
		soldiers.append(s)
		pass
	
	var ssize	= get_children().size()
	var kv		= int(sqrt(ssize))
	var nr 		= 0
	while nr < ssize:
		var col = nr%kv - kv/2
		var row = nr/kv -kv/2
		var x =  col*9
		var y = row*9
		var s = soldiers[nr]
		s.position = Vector2(x,y)
		s.army_position =  global_position + s.position
		s.start_position = s.position # positionen i hærens opstilling
		nr = nr +1
		pass
	
		
	pass


func _process(delta):
	if controllable and Input.is_action_just_pressed("mouse_left"):
		destination = get_global_mouse_position()
		for s in soldiers:
			s._march_to_destination(s.start_position + destination)
	pass
