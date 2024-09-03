extends Node2D

# egenskaber for soldaten
@export var king_code 	= 0
@export var dead_risk	= 0.1
@export var debug_on	= false

var army_position:Vector2 = Vector2.ZERO	

var start_position:Vector2 # Sættes i _ready : soldatens position i "hæren"/"army"
var stepLeft			= false
var dead 				= false

func _ready():
	print("soldier ready")
## Connected to Signal:"change_state" from the state-machine
	$Statemachine.change_of_state.connect(soldier_state_change)
	$Statemachine._state_machine_init()
	#start_position	= position
	#army_position	= global_position
	if debug_on:
		$Nodes/Label_debug.visible = true
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
	$Nodes/Label_debug.set_text(new_state.name)
	pass
	

func _on_area_2d_area_entered(area):
	var other = area.get_parent().get_parent()
		
	if not other.dead and king_code != other.king_code:
		$Statemachine._new_data("add_enemy",other)
		pass
	pass


func _on_area_2d_area_exited(area):
	var other = area.get_parent().get_parent()
	
	if other.king_code != king_code:
		$Statemachine._new_data("delete_enemy",other)
		pass	
	pass
