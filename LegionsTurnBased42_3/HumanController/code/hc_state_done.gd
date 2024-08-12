extends HC_State
# human controller 
# DONE STATE

var armySlected : Army

func readyMode():
	#print("human controller - SELECTED STATE - ready mode")
	setProcess()
	pass

func processMode(delta):	
	pass

func setData(a):
	armySlected = a;
	armySlected.setSelected()
	
func armyJustDone(army:Army):
	if army == armySlected:
		setState($"../hc_state_idle")
	pass
	
