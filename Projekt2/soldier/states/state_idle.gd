# SOLDIER
# IDLE STATE 

extends state

var soldier_node
var state_combat
var state_machine

func _ready():
	soldier_node	= $"../.."
	state_machine	= $".."
	state_combat	= $"../state_combat"
	pass

func _state_init(code,data):
	pass
	
func _stat_run():
	pass
	

func _new_data(code,data):
	if code == "add_enemy":
		state_combat._state_init("position",soldier_node.position)
		state_combat._new_data("add_enemy",data)
		state_machine._change_state(state_combat)
		pass
	pass
