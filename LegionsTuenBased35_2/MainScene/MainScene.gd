extends Node2D

var list_team1					= []
var selectedArmy : ArmyScene	= null


func _ready():
	list_team1 = $Team1.get_children()
	pass

func _input(event):
	if Input.is_action_just_pressed("mouse_left"):
		
		if selectedArmy == null:	
			for army in list_team1:
				if army._is_army_position(get_global_mouse_position()):
					army._set_selection(true)
					selectedArmy = army
					return
		
		if selectedArmy != null:
			if selectedArmy._is_army_position(get_global_mouse_position()):
				selectedArmy._set_selection(false)
				selectedArmy = null
				return
				
	pass
