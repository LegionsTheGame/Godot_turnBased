extends Node2D
class_name Army

@export var king_code 		= 0
@export var controllable 	= false

var destination : Vector2 

var soldiers = []

func _ready():
	var sl = true;
	
	for s in get_children():
		
		##Connect to soldier - dead signal
		s.dead_signal.connect(soldier_is_dead)
		
		##Soldiers king code - given from army
		s.king_code = king_code
		
		##Soldiers - use different feets when marching...
		s.stepLeft = sl
		sl = not sl
		
		soldiers.append(s)
		pass

	destination = global_position
	square_formation()	
	#var ssize	= get_children().size()
	#var kv		= int(sqrt(ssize))
	#var nr 		= 0
	#destination = global_position
	#while nr < ssize:
		#var col = nr%kv - kv/2
		#var row = nr/kv -kv/2
		#var x =  col*9
		#var y = row*9
		#var s = soldiers[nr]
		#s.position = Vector2(x,y)
		#s.army_position =  destination + s.position
		#s.start_position1 = s.position # positionen i hærens opstilling
		#nr = nr +1
		#pass
	pass


func _process(delta):
	if controllable and Input.is_action_just_pressed("mouse_left"):
		destination = get_global_mouse_position()
		for s in soldiers:
			s._march_to_destination(s.start_position1 + destination)
	pass
pass

func soldier_is_dead(soldier):
	print("A soldier is dead", soldier)	
	soldiers.erase(soldier)
	
	square_formation()
	
pass

func square_formation():
	var ssize	= soldiers.size()
	var kv		= int(sqrt(ssize))
	var nr 		= 0
	#destination = global_position
	while nr < ssize:
		var col = nr%kv - kv/2
		var row = nr/kv -kv/2
		var x =  col*9
		var y = row*9
		var s = soldiers[nr]
		#s.position = Vector2(x,y)
		s.start_position1 = Vector2(x,y)# s.position # positionen i hærens opstilling
		s.army_position =  destination + s.start_position1
		nr = nr +1
		pass
	pass
	


