# army
#############
# selected - state
#############
extends state

var army_node
var selected_sprite
var state_idle
var state_turn
var state_machine

func _ready():
	army_node		=	$"../.."
	selected_sprite	=	$"../../selected_sprite"
	state_idle		=	$"../state_idle"
	state_turn		=	$"../state_turn"
	state_machine	=	$".."
	
func _state_init(code,data):
	_new_data(code,data)
	pass
	
func _stat_run():
	if not army_node.controllable: return
	
	if Input.is_action_just_pressed("mouse_left"):
		var dist = get_global_mouse_position() - army_node.global_position
		if dist.length() < army_node.selection_radius:
			#print("army valgt")
			state_machine._change_state_data("un_selected",null,state_idle)
		else:
			# Destination selected
			state_machine._change_state_data("turn",get_global_mouse_position(),state_turn)
			pass
	pass
	
func _new_data(code,data):
	if code == "selected":
		selected_sprite.visible = true
		selected_sprite.global_position = army_node.destination
	pass
