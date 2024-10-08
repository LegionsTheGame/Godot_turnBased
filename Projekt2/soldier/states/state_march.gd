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
	
	step_left = soldier_node.stepLeft
	
	#Fjerner muligheden for at march gemmer en fjende fra før
	enemy = null 
	
	if code == "destination":
		destination = data
		#Destinationen for en march - er hær-positionen 
		soldier_node.army_position = data
	pass
	
func _stat_run():
	var direction = destination - soldier_node.global_position
	
	if direction.length() > 1:
		_walk_in_direction(direction)
	
	elif enemy !=  null:
		state_combat._new_data("add_enemy",enemy)
		state_machine._change_state(state_combat)
		
	elif enemy == null:
		state_machine._change_state(state_idle)
	
	pass
	
func _walk_in_direction(direction):	
	if direction.length() > 1:
		var velocity = direction.limit_length(1);#RandomNumberGenerator.new().randf_range(0.5, 1))

		if step_left:
			velocity = velocity.rotated(PI/(9))
		else:
			velocity = velocity.rotated(-PI/(9))
		step_time = step_time - 1
		if step_time <= 0:
			step_time = step_time_limit
			step_left = ! step_left
		
		soldier_node.global_position = soldier_node.global_position + velocity
	pass

func _new_data(code,data):
	if code == "add_enemy" and enemy == null:
		# data er enemy
		destination = data.global_position
		enemy = data
		pass
	
	if code == "stop_march":
		# VI STOPPER BEVÆGELSEN
		destination = soldier_node.global_position
		pass
	
	pass
