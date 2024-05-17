extends Node2D
class_name HumanController

@onready var state : HC_State = $hc_state_idle


func _ready():
	for a in $HumanTeam.get_children():
		a.setIdle();
		a.clickDetectionSignal.connect(sendClickDetectionSignalRecived);
		a.armyIsJustDoneSignal.connect(armyIsJustDoneSignalRecived);
	pass

func _process(delta):
	state.run(delta)
	pass

func sendClickDetectionSignalRecived(army:Army):
	state.armyClicked(army)
	pass

func armyIsJustDoneSignalRecived(army:Army):
	state.armyJustDone(army)
	pass
