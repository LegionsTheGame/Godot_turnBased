extends Node2D

onready var info_text : Label			= $Label

var turnCount : int				= 1

var list_team1					= []
var selectedArmy : ArmyScene	= null
var selectedIndex : int			= 0

func _ready():
	list_team1.append_array($Team1.get_children())
	list_team1.append_array($Team2.get_children())
	for a in list_team1:
		a.connect("kill_signal",self,"killed_army")
	selectedArmy 			= list_team1[selectedIndex]
	selectedArmy._set_selection(true)
	info_text.text = "Runde nummer " + str(turnCount)
	pass
	
func _process(delta):
	#info_text.text = str(selectedArmy) + " " + str(selectedArmy.currentState) + " " + str(selectedArmy.currentState == selectedArmy.STATE.IDLE)
	
	# Automatisk skift til næste brik / enhed der skal flyttes
	if selectedIndex < list_team1.size():
		# Turen for en enkelt enhed afsluttes og der skiftes til næste enhed
		if selectedArmy!= null: 
			if selectedArmy.statesCompleted.size() > 1:
				print("næste hær - den sidste havde kørt mere end en state!")
				if selectedArmy.statesCompleted[selectedArmy.statesCompleted.size()-1] == selectedArmy.STATE.IDLE:
					selectedArmy._set_selection(false)
					selectedIndex = selectedIndex + 1
					selectedArmy = list_team1[selectedIndex%list_team1.size()]
					selectedArmy._set_selection(true)
	else:
		#Ny runde startes
		turnCount = turnCount + 1
		info_text.text = "Runde nummer " + str(turnCount)
		print("Ny runde!");
		for a in list_team1:
			a.statesCompleted.clear()
			a.statesCompleted.append(a.STATE.IDLE)
			#a._set_selection(false)
		selectedIndex	= 0
		selectedArmy 	= list_team1[selectedIndex]
		selectedArmy._set_selection(true)
	pass
	
	
func killed_army(army:ArmyScene):
	print("recieved kill signal")
	list_team1.erase(army)
	remove_child(army)
	army.queue_free()
	pass


func _input(event):	
	if Input.is_action_just_pressed("mouse_left"):
		
		# SPILLEREN vælger selv en ny hær
		if selectedArmy == null:	
			for army in list_team1:
				if army._is_army_position(get_global_mouse_position()):
					army._set_selection(true)
					selectedArmy 	= army
					selectedIndex	= list_team1.find(army) 
					return
		
		# SPILLEREN fra-vælger sin hær
		if selectedArmy != null:
			if selectedArmy._is_army_position(get_global_mouse_position()):
				selectedArmy._set_selection(false)
				selectedArmy = null
				return
				
			else:
				var valid_move = selectedArmy._set_destination(get_global_mouse_position())
				if not valid_move :
					pass
				else:
					# SPILLEREN har lavet en beslutning om hvad, der skal gøres - her kan compteren tage over og vælge den næste hær
					selectedArmy._set_attack_destination(get_global_mouse_position())
					selectedArmy._set_selection(false)
					#selectedArmy = null

	pass
