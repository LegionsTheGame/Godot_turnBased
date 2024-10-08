extends Node2D
class_name Army

var leader : Soldier

var selection_radius = 80

@export var king_code 		= 0
@export var controllable 	= false
@export var debug_mode		= false

var destination : Vector2
var heading : float

var soldiers = []


### initialization and control of statemachine

func _ready():
	_army_init()
	$Statemachine._state_machine_init()
	$Statemachine.change_of_state.connect(soldier_state_change)
	pass
	
func _process(delta):
	$Statemachine._state_machine_run(delta)
	pass


## Connected to Signal:"change_state" from the state-machine
func soldier_state_change(new_state):
	if debug_mode:
		$Label_debug.set_text(new_state.name)
		$Label_debug.global_position = destination + Vector2.UP*80
	pass

func soldier_is_fighting_recived(soldier):
	#print("A soldier is fighting", soldier)
	$Statemachine._new_data("fighting",soldier)
	pass


func _army_init():
	var stepValue = true;
	for s in $all_soldiers.get_children():
		##Connect to soldier - dead signal
		s.dead_signal.connect(soldier_is_dead_recived)		
		##Connect to soldier - fighting signal
		s.fighting_signal.connect(soldier_is_fighting_recived)		
		##Soldiers king code - given from army
		s.king_code = king_code
		##Soldiers - use different feets when marching...
		s.stepLeft = stepValue
		stepValue =! stepValue
		soldiers.append(s)
		pass
	#Setting the first soldier as "leader"
	soldiers[0].leader = true	
		
	destination = global_position
	square_formation(destination)
	leader = soldiers[0]
		
	pass

#### army functions - used by the state-machine

func soldier_is_dead_recived(soldier):
	#print("A soldier is dead", soldier)	
	soldiers.erase(soldier)
	
	#square_formation(destination)
	if soldiers.size() > 0:
		leader = soldiers[0]
		$Statemachine._new_data("dead_soldier",soldier)
pass

	
func square_formation(dest):
	var ssize	= soldiers.size()
	var kv		= int(sqrt(ssize))
	var nr 		= 0
	#destination = global_position
	while nr < ssize:
		var col = nr%kv - (kv)/2
		var row = nr/kv -(kv)/2
		var x =  col*9 
		var y = row*9 -5
		var s = soldiers[nr]
		
		#s.position = Vector2(x,y)
		
		s.start_position1 = Vector2(x,y).rotated(heading)# s.position # positionen i hærens opstilling
		s.army_position =  dest + s.start_position1
		nr = nr +1
		pass
	destination = dest 
	pass

func rotate_formation(angle):
	angle = angle - PI/2 # hærens design svarer ikke helt til rotationen!
	for s in soldiers:
		var add_angle = angle -heading
		s.start_position1 = s.start_position1.rotated(add_angle) 
		s.army_position =  destination + s.start_position1
		pass
	heading = angle 
	pass

func move_formation(dest):
	for s in soldiers:
		s.army_position =  dest + s.start_position1
		pass
	destination = dest 
	pass
	
func stop_soldiers():
	print("STOP all soldiers...")
	if soldiers.size() > 0:
		for s in soldiers:
			s.start_position1 = s.position
			s.army_position = s.global_position
			s.stop_march()
	
	pass

################

#func _ready():
	#var stepValue = true;	
	#for s in $all_soldiers.get_children():
		###Connect to soldier - dead signal
		#s.dead_signal.connect(soldier_is_dead_recived)		
		###Soldiers king code - given from army
		#s.king_code = king_code
		###Soldiers - use different feets when marching...
		#s.stepLeft = stepValue
		#stepValue =! stepValue
		#soldiers.append(s)
		#pass
	#destination = global_position
	#square_formation(destination)
	#leader = soldiers[0]
		#
	#pass
#
#
#func _process(delta):
	#if not controllable: return
	#
	#if Input.is_action_just_pressed("mouse_left"):
		#destination = get_global_mouse_position()
		#$selected_sprite.global_position = destination
		#for s in soldiers:
			#s._march_to_destination(s.start_position1 + destination)
	#pass
	#
	#if Input.is_action_just_pressed("r"):
		#rotate_formation(PI/8)
		#pass
	#
	#
#pass
#
#
#
#func soldier_is_dead_recived(soldier):
	#print("A soldier is dead", soldier)	
	#soldiers.erase(soldier)
	#
	#square_formation(destination)
	#if soldiers.size() > 0:
		#leader = soldiers[0]
#pass
#
#func square_formation(dest):
	#var ssize	= soldiers.size()
	#var kv		= int(sqrt(ssize))
	#var nr 		= 0
	##destination = global_position
	#while nr < ssize:
		#var col = nr%kv - kv/2
		#var row = nr/kv -kv/2
		#var x =  col*9
		#var y = row*9
		#var s = soldiers[nr]
		#
		##s.position = Vector2(x,y)
		#s.start_position1 = Vector2(x,y)# s.position # positionen i hærens opstilling
		#s.army_position =  dest + s.start_position1
		#nr = nr +1
		#pass
	#pass
#
#func rotate_formation(angle):
	#for s in soldiers:
		#s.start_position1 = s.start_position1.rotated(angle) 
		#s.army_position =  destination + s.start_position1
	#pass

