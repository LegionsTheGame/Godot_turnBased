extends "res://ArmyScene/script_army.gd"

@onready var arrow_scene = load("res://ArcherScene/arrow_scene.tscn")
var SHOOTING = 6

func _ready():
	$MoveArea/ShootingArea.team_number = team_number
	$MoveArea/ShootingArea.signalEnemyTargetSelected.connect(recivedSignalEnemyTargetSelected)
	
func _process(delta):
	super._process(delta)
	if state == SHOOTING:
		$MoveArea.visible	= false
		pass
	pass	
	
func set_destination(p:Vector2):
	if $MoveArea.inside(p):
		destination = p
	elif $MoveArea/ShootingArea.inside(p):
		pass
	else:
		state = READY

func recivedSignalEnemyTargetSelected(army:Army):
#	army.animationplayer.play("explotion")
	var arrow : Arrow = arrow_scene.instantiate()
	add_child(arrow)
	arrow.arrowHitTarget.connect(targetHitSignalRecived)
	arrow.position = Vector2.ZERO
	arrow.set_destination(army)
	state = SHOOTING
	pass

func targetHitSignalRecived():
	print("The target is hit!")
	state = DONE_SIGNAL
	pass
