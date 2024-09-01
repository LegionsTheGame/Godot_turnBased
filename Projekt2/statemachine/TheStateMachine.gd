# The State Machine
extends Node2D

# state
signal change_of_state(state)
var current_state : state

func _state_machine_init():
	#den første state i state-machine er state_idle
	#opret "chid-state" og kald den "state_idle"
	var new_state = $state_idle
	new_state._state_init("",null)
	_change_state(new_state)
	pass

func _state_machine_run(delta):
	current_state._stat_run()
	pass

func _new_data(code,data):
	current_state._new_data(code,data)
	pass

func _change_state_data(code, data, new_state):
	new_state._state_init(code,data)
	_change_state(new_state)
	pass

func _change_state(new_state):
	current_state = new_state
	emit_signal("change_of_state",new_state)
	pass
	
