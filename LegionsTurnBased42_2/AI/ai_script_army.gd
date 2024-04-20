extends "res://ArmyScene/script_army.gd"

func _make_move():
	var rng = RandomNumberGenerator.new()
	print(rng.randf())
	var saved_state = rng.state # Store current state.
	print(rng.randf()) # Advance internal state.
	rng.state = saved_state # Restore the state.
	print(rng.randf()) # Prints the same value as in previous.

	pass
