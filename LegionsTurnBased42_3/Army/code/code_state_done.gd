extends State
# DONE STATE

var sendsignal : bool = true

func readyMode():
	moveAreaVisible(false)
	sendArmyIsJustDoneSignal()
