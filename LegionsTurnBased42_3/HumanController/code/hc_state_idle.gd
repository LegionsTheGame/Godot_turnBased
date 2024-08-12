extends HC_State
# human controller
# IDLE STATE

func readyMode():
	#print("human controller - IDLE STATE - ready mode")
	if get_parent().all_armies_done():
		setState($"../hc_state_done")
	setProcess()
	pass

func processMode(delta):
	pass

func armyClicked(army:Army):
	setState($"../hc_state_selected",army)
	pass
	
	
