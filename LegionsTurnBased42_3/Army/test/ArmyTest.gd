extends Node2D
# ARMY TEST - SCENE

func _ready():
	for a in $HumanTeam.get_children(): 	a.teamNumber = 0;
	for a in $ComputerTeam.get_children():	a.teamNumber = 1;


func _process(delta):
	pass


func _on_button_button_down():
	for a in $HumanTeam.get_children():		a.reset()



func _on_computer_reset_button_down():
	for a in $ComputerTeam.get_children():	a.reset()
