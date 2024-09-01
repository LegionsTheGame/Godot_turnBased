# SOLDIER
# IDLE STATE 

extends state

var state_combat
var state_machine

func _ready():
	state_machine	= $".."
	state_combat	= $"../state_combat"
	pass
	
func _new_data(code,data):
	if code == "add_enemy":
		state_machine._change_state_data("add_enemy",data,state_combat)
		pass
	pass
