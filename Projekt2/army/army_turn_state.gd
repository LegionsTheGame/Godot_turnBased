# army
#############
# turn - state
#############
extends state

var army_node
var selected_sprite
var state_idle
var state_march
var state_machine

###
var new_destination: Vector2
var new_heading: float

func _ready():
	army_node		=	$"../.."
	selected_sprite	=	$"../../selected_sprite"
	state_idle		=	$"../state_idle"
	state_march		=	$"../state_march"
	state_machine	=	$".."
	
func _state_init(code,data):
	_new_data(code,data)
	pass
	
func _stat_run():
	#for s in army_node.soldiers:
	#	if s.leader and army_node.controllable:
	#		if s.get_node("Statemachine").current_state.name == "state_idle":
	if army_node.soldiers.size() > 0 && army_node.soldiers[0].on_army_position():
		state_machine._change_state_data("march",get_global_mouse_position(),state_march)
		#army_node.move_formation(new_destination)
		pass
	pass
	
func _new_data(code,data):
	if code == "turn":
		new_destination = data
		var dist:Vector2 = (army_node.destination - new_destination)
		new_heading = dist.angle()
		army_node.rotate_formation(new_heading)
		selected_sprite.visible = false
		#army_node.move_formation(new_destination)
	pass
