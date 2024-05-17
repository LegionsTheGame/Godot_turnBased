extends State
# IDLE STATE

func readyMode():
	moveAreaVisible(false)
	setProcess()

func processMode(delta):
	if Input.is_action_just_pressed("mouseLeft"):
		if distToMouse() < armyRadius():
			sendClickDetectionSignal()
	pass
