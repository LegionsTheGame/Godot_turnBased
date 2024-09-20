# The State Machine
extends Node2D
class_name StateMachine

# state
signal change_of_state(state)
var current_state : Super_state

#########################################################

func _run(delta):
	current_state._run()
	pass

func _new_data(code,data):
	current_state._data(code,data)
	pass

func _set_state(code,data,new_state):
	new_state._start(code,data)
	current_state = new_state
	emit_signal("change_of_state",new_state)
	pass
