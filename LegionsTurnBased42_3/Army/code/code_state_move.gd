# MOVE STATE
extends State

var destination : Vector2
var velocity : Vector2 = Vector2.ZERO

func setData(data):
	destination = data

func readyMode():
	moveAreaVisible(false)
	setProcess()

func processMode(delta):
	var L = destination - global_position
	if L.length() > 5:
		velocity = L.normalized()
		get_parent().global_position += velocity 
	else:
		velocity *= 0
		setState($"../stateDone")
	pass

func armyCollision(a):
	if a is Army:
		get_parent().global_position -= 2*velocity
		destination = global_position
		var attackState = $"../stateAttack"
		attackState.setData(a) 
		setState(attackState)
	pass
