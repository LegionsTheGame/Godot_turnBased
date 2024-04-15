extends "res://ArmyScene/script_army.gd"

func _ready():
	$MoveArea/ShootingArea.team_number = team_number
	$MoveArea/ShootingArea.signalEnemyTargetSelected.connect(recivedSignalEnemyTargetSelected)
	
func set_destination(p:Vector2):
	if $MoveArea.inside(p):
		destination = p
	elif $MoveArea/ShootingArea.inside(p):
		pass
	else:
		state = READY

func recivedSignalEnemyTargetSelected(army:Army):
	army.animationplayer.play("explotion")
	destination = global_position
	state = DONE
	$MoveArea.visible = false
	emit_signal("signalDone",self)
	print("der er modtaget signal om at et enemy target er valgt!")
	pass
