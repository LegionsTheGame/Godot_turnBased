extends Node2D

var humanTeam = []

var computerTeam 	= []
var armyInFocus :Army	= null
var indexArmy = 0

func _ready():
	humanTeam = $"../HumanTeam".get_children()
	computerTeam = get_children()
	armyInFocus = computerTeam[indexArmy]
	for a in computerTeam:
		var army : Army = a 
		army.signalDone.connect(_recived_army_done)
		pass
	pass


func _process(delta):
	if armyInFocus.is_ready():
		armyInFocus.set_selected()
		var enemy = humanTeam[indexArmy%humanTeam.size()]
		
		var new_dir = (enemy.global_position - armyInFocus.global_position).normalized()
		var new_pos = armyInFocus.global_position + new_dir*100
		armyInFocus.set_destination(new_pos)
	pass
	
	
func _recived_army_done(army:Army):
	#print("computer army done .. new army ",indexArmy )
	if indexArmy < computerTeam.size()-1:
		indexArmy +=1 
		armyInFocus = computerTeam[indexArmy]
		
	pass

func _on_reset_computer_turn_button_down():
	indexArmy = 0
	armyInFocus = computerTeam[indexArmy]
	for a in computerTeam:
		a.set_ready()
	pass
