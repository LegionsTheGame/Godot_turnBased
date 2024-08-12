extends Node2D

var humanTeam = []

var computerTeam 	= []
var armyInFocus :Army	= null
var indexArmy = 0

var setUpTeam = true

signal signalComputerTurnFinished 

func _ready():	
	humanTeam = $"../HumanTeam".get_children()
	computerTeam = get_children()
	armyInFocus = computerTeam[indexArmy]
	for a in computerTeam:
		var army : Army = a 
		army.signalDone.connect(_recived_army_done)
		army.signalDead.connect(_recived_army_done)
		army.set_done()
		army.set_army_team(0)
		pass
	pass


func _process(delta):
	
	if armyInFocus.is_dead():
		if indexArmy < computerTeam.size()-1: 
			indexArmy +=1 
			armyInFocus = computerTeam[indexArmy]
		else:
			emit_signal("signalComputerTurnFinished")
		pass
	
	if armyInFocus.is_ready():
		#print("computer started moving", indexArmy)
		armyInFocus.set_selected()
		var enemy = humanTeam[indexArmy%humanTeam.size()]
		
		var new_dir = (enemy.global_position - armyInFocus.global_position).normalized()
		var new_pos = armyInFocus.global_position + new_dir*100
		
		#print(armyInFocus.global_position,new_pos)
		
		armyInFocus.set_destination(new_pos)
	pass
	
	
func _recived_army_done(army:Army):
	#print("computer done .. index",indexArmy ," ", army.name)
	if indexArmy < computerTeam.size()-1:
		indexArmy +=1 
		armyInFocus = computerTeam[indexArmy]
	else:
		#print("computer finished", indexArmy)
		emit_signal("signalComputerTurnFinished")
	pass


func _on_reset_computer_turn_button_down():
	for a in computerTeam:
		a.set_ready()
	indexArmy = 0
	armyInFocus = computerTeam[indexArmy]
	pass
