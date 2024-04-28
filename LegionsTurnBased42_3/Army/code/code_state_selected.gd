# SELECTED STATE
extends State

func readyMode():
	moveAreaVisible(true)
	setProcess()
	pass

func processMode(delta):
	if Input.is_action_just_pressed("mouseLeft"):

		if distToMouse() <= moveRadius():	
			setState($"../stateMove", get_global_mouse_position())
		else:
			setState($"../stateReady")
			
	pass
