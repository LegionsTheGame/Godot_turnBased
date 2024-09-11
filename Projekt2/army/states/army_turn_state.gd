# army
#############
# turn - state
#############
extends state

var army_node
var selected_sprite
var state_idle
var state_march
var state_battle
var state_machine

###
var new_destination: Vector2
var new_heading: float

func _ready():
	army_node		=	$"../.."
	selected_sprite	=	$"../../selected_sprite"
	state_idle		=	$"../state_idle"
	state_march		=	$"../state_march"
	state_battle	=	$"../state_battle"
	state_machine	=	$".."
	
func _state_init(code,data):
	_new_data(code,data)
	pass
	
func _stat_run():
	if army_node.soldiers.size() > 0 && army_node.soldiers[0].on_army_position():
		state_machine._change_state_data("march",new_destination, state_march)
		pass
	pass
	
func _new_data(code,data):
	if code == "fighting":
		state_machine._change_state_data("fighting",data,state_battle)
		pass
	
	if code == "turn":
		new_destination = data
		var dist:Vector2 = (army_node.destination - new_destination)
		new_heading = dist.angle()
		selected_sprite.visible = false
		army_node.rotate_formation(new_heading)
		#army_node.heading 		= new_heading
		#army_node.destination	= new_destination

	pass
