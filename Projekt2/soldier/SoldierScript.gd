extends Node2D

# egenskaber for soldaten
@export var king_code = 0
@export var dead_risk = 0.1
var dead = false


func _ready():
	$Statemachine.change_of_state.connect(soldier_state_change)
	$Statemachine._state_machine_init()
	pass


func _process(delta):
	$Statemachine._state_machine_run(delta)
	pass

func _march_to_destination(dest):
	var new_state = $Statemachine/state_march
	new_state._state_init("destination",dest)
	$Statemachine._change_state(new_state)
	pass

func soldier_state_change(new_state):
	#print(state,self)
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