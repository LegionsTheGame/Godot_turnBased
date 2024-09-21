##############################################################################
# SOLDIER - DEAD STATE 							 							 #
##############################################################################
##############################################################################
extends soldier_standby_state 	#forsøg på at genbruge variabler
###############################################################################

func _start(code, data):
	_data(code,data)
	pass
	
func _run():
	pass

func _data(code,data):
	if code == "dead" and not soldierNode.dead:
		soldierNode.dead = true
		animationNode.play("killed")
	pass
