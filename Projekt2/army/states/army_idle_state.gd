# Army
#############
# idle state 
#############
extends state

var army_node
var selected_sprite
var state_selected
var state_machine

func _ready():
	army_node 		= $"../.."
	selected_sprite	= $"../../selected_sprite"
	state_machine	= $".."
	state_selected	= $"../state_selected"
	pass

func _state_init(code,data):
	_new_data(code,data)
	pass
	
func _stat_run():
	if not army_node.controllable: return
	
	if Input.is_action_just_pressed("mouse_left"):
		var dist = get_global_mouse_position() - army_node.destination
		if dist.length() < army_node.selection_radius:
			#print("army valgt")
			state_machine._change_state_data("selected",null,state_selected)
			pass
	pass
	
func _new_data(code,data):
	if code == "":
		army_node._army_init() # KUN FØRSTE GANG STATEN KØRES
		
	if code == "un_selected":
		selected_sprite.visible = false
	pass
