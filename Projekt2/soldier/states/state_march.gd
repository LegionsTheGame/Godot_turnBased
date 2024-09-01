# SOLDIER
# MARCH

extends state
#####################
# marching stuff
var destination : Vector2

var step_left : bool
var step_time : int
var step_time_limit : int = 8

# hvis soldaten møder en fjende
# ændres destinationen
# og næste state er "combat-state"
var enemy = null
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
	var direction = destination - soldier_node.global_position
	
	if direction.length() > 1:
		_walk_in_direction(direction)
	elif enemy == null:
		state_machine._change_state(state_idle)
	elif enemy !=  null:
		#state_combat._state_init("position",soldier_node.position)
		state_combat._new_data("add_enemy",enemy)
		state_machine._change_state(state_combat)
	pass
	
func _walk_in_direction(direction):	
	if direction.length() > 1:
		var velocity = direction.limit_length(1)
		
		if step_left:
			velocity = velocity.rotated(PI/8)
		else:
			velocity = velocity.rotated(-PI/8)
		step_time = step_time - 1
		if step_time <= 0:
			step_time = step_time_limit
			step_left = ! step_left
		
		soldier_node.global_position = soldier_node.global_position + velocity
	pass

func _new_data(code,data):
	if code == "add_enemy":
		destination = data.global_position
		enemy = data
		pass
	pass
