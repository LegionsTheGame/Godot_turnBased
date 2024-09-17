extends Node2D
class_name Soldier
#
signal dead_signal(soldier)
signal fighting_signal(soldier)

# egenskaber for soldaten
@export var king_code 	= 0
@export var dead_risk	= 0.1
@export var debug_on	= false

@export var leader		= false

var army_position:Vector2 		#"Global position" i hæren	
var start_position1:Vector2 	#"Lokal position" i hæren

var stepLeft			= false
var killed 				= false : get = get_dead, set = set_dead

func _ready():
## Connected to Signal:"change_state" from the state-machine
	$Statemachine.change_of_state.connect(soldier_state_change)
	$Statemachine._state_machine_init()
	#start_position	= position
	#army_position	= global_position
	if debug_on:
		$Label_debug.visible = true
	pass
pass

func _process(delta):
	$Statemachine._state_machine_run(delta)
	pass

func _march_to_destination(dest):
	var new_state = $Statemachine/state_march
	new_state._state_init("destination",dest)
	$Statemachine._change_state(new_state)
	pass

## Connected to Signal:"change_state" from the state-machine
func soldier_state_change(new_state):
	$Label_debug.set_text(new_state.name)
	pass
	

func _on_area_2d_area_entered(area):
	var other = area.get_parent().get_parent()
		
	if not other.get_dead() and king_code != other.king_code:
		$Statemachine._new_data("add_enemy",other)
		# har mødt en fjende - sender "fighting" signalet
		emit_signal("fighting_signal",self)
		pass
	pass


func _on_area_2d_area_exited(area):
	var other = area.get_parent().get_parent()
	
	if other.king_code != king_code:
		$Statemachine._new_data("delete_enemy",other)
		pass	
	pass

func set_dead(value):
	killed = value
	## SEND DEAD-SIGNAL
	emit_signal("dead_signal",self)
	
func get_dead():
	return killed

func stop_march():
	$Statemachine._new_data("stop_march",army_position)	

func on_army_position():
	var d : Vector2 = global_position - army_position
	return d.length() < 2 # soldaten har nået sin position...	
	pass
