extends Area2D
class_name Army

@onready var state : State = $stateReady
signal clickDetectionSignal(army);
signal armyIsJustDoneSignal(army);

var armyRadius	= 10
var moveRadius	= 100
var teamNumber	= 0
var health		= 4


func _ready():
	$CollisionShape2D.shape.radius = armyRadius
	pass

func _process(delta):
	state.run(delta)
	pass

func setReady(): state.setState($stateReady)

func setIdle(): state.setState($stateIdle)

func setSelected(): state.setState($stateSelected)

func isDone(): return state == $stateDone
	
func _on_army_entered(area):
	state.armyCollision(area)
	pass

func takeDamage(v):
	health -= v
	$ArmySprite.update_drawing()

func sendClickDetectionSignal():
	emit_signal("clickDetectionSignal",self)

func sendArmyIsJustDoneSignal():
	emit_signal("armyIsJustDoneSignal",self)
