extends Area2D
class_name Army

@onready var state : State = $stateReady

var armyRadius = 10
var moveRadius = 100
var teamNumber = 0

func _ready():
	$CollisionShape2D.shape.radius = armyRadius
	pass

func _process(delta):
	state.run(delta)
	pass

func reset():
	state.setState($stateReady)
	pass

func _on_army_entered(area):
	state.armyCollision(area)
	pass
