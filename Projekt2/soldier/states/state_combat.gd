# SOLDIER #
# COMBAT STATE #
extends state

############################
#combat data
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

func _stat_run():
	for s in enemies:
		if s.dead: enemies.erase(s)		
		
	if soldier_node.dead:
		state_machine._change_state(state_dead)
	elif enemies.size() > 0:
		generatePercentDeadChance(soldier_node.dead_risk)		
		if not animation_node.is_playing():
			animation_node.play("combat_animation")		
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
	# dette er en random-død < percent % generator - for at teste den visuelle effekt
	if not soldier_node.dead:
		#if not animation_node.is_playing():
			var r = RandomNumberGenerator.new().randf_range(0, 1)
			if r*100 < percent*enemies.size():
				animation_node.play("dead_animation")
				soldier_node.dead = true
pass	
