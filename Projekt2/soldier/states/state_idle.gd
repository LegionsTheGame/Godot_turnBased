# SOLDIER
# IDLE STATE 

extends state

var state_combat
var state_march
var state_machine
var soldier_node

func _ready():
	state_machine	= $".."
	state_combat	= $"../state_combat"
	state_march		= $"../state_march"
	soldier_node	= $"../.."
	pass

func _stat_run():
	# Soldaten skal være på hær-positionen hvis den ikke kæmper...
	var sPos: Vector2 = soldier_node.global_position
	var aPos: Vector2 = soldier_node.army_position
	if (aPos - sPos).length() > 1:
		state_machine._change_state_data("destination",aPos, state_march) 
	pass	

func _new_data(code,data):
	if code == "add_enemy":
		state_machine._change_state_data("add_enemy",data,state_combat)
		pass
	pass
