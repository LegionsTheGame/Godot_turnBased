# army
#############
# march - state
#############
extends state

var army_node
var selected_sprite
var state_idle
var state_battle
var state_machine

###
var new_destination: Vector2
var new_heading: float

func _ready():
	army_node		=	$"../.."
	selected_sprite	=	$"../../selected_sprite"
	state_idle		=	$"../state_idle"
	state_battle	=	$"../state_battle"	
	state_machine	=	$".."
	
func _state_init(code,data):
	_new_data(code,data)
	pass
	
func _stat_run():
	if army_node.soldiers.size() > 0 && army_node.soldiers[0].on_army_position():
		state_machine._change_state_data("un_selected",null,state_idle)
		pass
	pass
	
func _new_data(code,data):
	if code == "fighting":
		state_machine._change_state_data("fighting",data,state_battle)
		pass
	
	if code == "march":
		army_node.move_formation(data)
	pass
