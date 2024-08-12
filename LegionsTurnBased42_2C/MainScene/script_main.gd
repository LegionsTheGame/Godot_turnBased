extends Node2D
class_name Main

@onready var humanNode		= $HumanTeam
@onready var computerNode	= $ComputerTeam

func _ready():
	pass


func _on_computer_team_signal_computer_turn_finished():
	humanNode._on_reset_human_turn_button_down()
	humanNode.selectNextFocusArmy()
	pass


func _on_human_team_signal_human_turn_finished():
	if $AutoNextTurn.button_pressed:
		computerNode._on_reset_computer_turn_button_down()
	pass
