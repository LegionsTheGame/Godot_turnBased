# Army
#############
# battle state 
#############
extends state

var army_node
var selected_sprite
var state_selected
var state_machine

var first_fighter # den første soldat i krig

var fighter_counter = 0

func _ready():
	army_node 		= $"../.."
	selected_sprite	= $"../../selected_sprite"
	state_machine	= $".."
	state_selected	= $"../state_selected"
	pass

func _state_init(code,data):
	first_fighter = null
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
	if code == "fighting":
		fighter_counter = fighter_counter +1
		if fighter_counter ==7:
			army_node.stop_soldiers()
			army_node.square_formation(army_node.soldiers[army_node.soldiers.size()/2].global_position)
			
			
	if code == "dead_soldier" and army_node.soldiers.size() > 0:
		var size = army_node.soldiers.size()
		var last = army_node.soldiers[size-1]
		last.start_position1	= data.start_position1
		last.army_position		= data.army_position
		
		#army_node.move_formation(army_node.destination + Vector2.LEFT*20)
	pass
