# SOLDIER #
# COMBAT STATE #
extends state

############################
#combat data
var center_position
var vel = Vector2(0.5,0.5)
var enemies = []
#############################
#node references
var soldier_node
var state_idle
var state_dead
var state_machine
var animation_node
#############################

func _ready():
	soldier_node = $"../.."
	state_idle = $"../state_idle"
	state_dead = $"../state_dead"
	state_machine = $".."
	animation_node = $"../../Nodes/AnimationPlayer"
	pass

func _state_init(code,data):
	if code == "position":
		center_position = data
	pass

func _stat_run():
	for s in enemies:
		if s.dead: enemies.erase(s)		
		
	if soldier_node.dead:
		state_machine._change_state(state_dead)
	elif enemies.size() > 0:
		generatePercentDeadChance(soldier_node.dead_risk)
		randomMoveFromCenter(1)
	else:
		state_machine._change_state(state_idle)
	pass

func _new_data(code,data):
	if code == "add_enemy":
		enemies.append(data)
		pass
	if code == "delete_enemy":
		enemies.erase(data)
		pass
	pass	
	
func generatePercentDeadChance(percent):
	# dette er en random-død < 1% generator - for at teste den visuelle effekt
	if not soldier_node.dead:
		if not animation_node.is_playing():
			var r = RandomNumberGenerator.new().randf_range(0, 1)
			#print("generated r (combat) :",r*100, self)
			if r*100 < percent:
				animation_node.play("new_animation")
				soldier_node.dead = true
pass	


func randomMoveFromCenter(l):
	var r = RandomNumberGenerator.new().randf_range(-PI/4, PI/4)
	vel = vel.rotated(r)
	var new_position = soldier_node.position + vel
	
	if (new_position - center_position).length() > l:
		vel = (center_position-soldier_node.position).limit_length(0.1)
		new_position = soldier_node.position + vel
	
	soldier_node.position = new_position
	pass
