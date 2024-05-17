extends HC_State
# human controller
# IDLE STATE

func readyMode():
	print("human controller - IDLE STATE - ready mode")
	setProcess()
	pass

func processMode(delta):
	pass

func armyClicked(army:Army):
	setState($"../hc_state_selected",army)
	pass
	
	
