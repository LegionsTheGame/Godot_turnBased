# SOLDIER
# MARCH

extends state
#####################
# marching stuff
var destination : Vector2
var direction :Vector2
var velocity : Vector2

#####################
var soldier_node
var state_combat
var state_idle
var state_machine

func _ready():
	soldier_node	= $"../.."
	state_machine	= $".."
	state_combat	= $"../state_combat"
	state_idle		= $"../state_idle"
	pass

func _state_init(code,data):
	if code == "destination":
		destination = data
	pass
	
func _stat_run():
	direction = destination - soldier_node.global_position
	
	if direction.length() > 1:
		velocity = direction.limit_length(1)
		soldier_node.global_position = soldier_node.global_position + velocity
	else:
		state_machine._change_state(state_idle)
	pass
	

func _new_data(code,data):
	if code == "add_enemy":
		state_combat._state_init("position",soldier_node.position)
		state_combat._new_data("add_enemy",data)
		state_machine._change_state(state_combat)
		pass
	pass
