extends Node2D


var computerTeam 	= []
var armyInFocus :Army	= null
var indexArmy = 0

func _ready():
	computerTeam = get_children()
	armyInFocus = computerTeam[indexArmy]
	for a in computerTeam:
		a.signalDone.connect(_recived_army_done)
	pass


func _process(delta):
	if armyInFocus.is_ready():
		armyInFocus.set_selected()
		var new_pos = armyInFocus.global_position + Vector2(-100,0)
		armyInFocus.set_destination(new_pos)
	pass
	
	
func _recived_army_done(army:Army):
	print("computer army done .. new army ",indexArmy )
	if indexArmy < computerTeam.size()-1:
		indexArmy +=1 
		armyInFocus = computerTeam[indexArmy]
		
	pass


func _on_reset_computer_turn_button_down():
	
	pass
