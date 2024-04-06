extends Node2D

onready var info_text : Label			= $Label

var list_team1					= []
var selectedArmy : ArmyScene	= null

func _ready():
	list_team1.append_array($Team1.get_children())
	list_team1.append_array($Team2.get_children())
	for a in list_team1:
		a.connect("kill_signal",self,"killed_army")
	info_text.text	= "Select an army by clicking on it"
	pass

func killed_army(army:ArmyScene):
	print("recieved kill signal")
	list_team1.erase(army)
	remove_child(army)
	army.queue_free()
	pass

func _input(event):	
	if Input.is_action_just_pressed("mouse_left"):
		info_text.text = "Info text"
		
		if selectedArmy == null:	
			for army in list_team1:
				if army._is_army_position(get_global_mouse_position()):
					info_text.text = "Select destination or enemy-target or deselect by clicking the army again"
					army._set_selection(true)
					selectedArmy = army
					return
		
		if selectedArmy != null:
			if selectedArmy._is_army_position(get_global_mouse_position()):
				info_text.text = "Army deselected - select new army by clicking on it"
				selectedArmy._set_selection(false)
				selectedArmy = null
				return
				
			else:
				var valid_move = selectedArmy._set_destination(get_global_mouse_position())
				if not valid_move :
					info_text.text = "This is to far - your army can only move to somewhere inside the circle!"
				else:
					selectedArmy._set_attack_destination(get_global_mouse_position())
					info_text.text = "Army moved to new destination!"
					selectedArmy._set_selection(false)
					selectedArmy = null
	pass
