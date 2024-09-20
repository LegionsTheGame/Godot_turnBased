##############################################################################
# SOLDIER - MARCHING STATE 						 							 #
##############################################################################
##############################################################################
extends soldier_standby_state 	#forsøg på at genbruge variabler
###############################################################################

func _start(code, data):
	_data(code,data)
	pass
	
func _run():
	var dist = soldierNode.destination - soldierNode.global_position
	#print("marching state bevæger soldaten")
	if dist.length() > 1:
		soldierNode.position = soldierNode.position + dist.normalized()
	else:
		stateMachine._set_state("",null, standbyState)
	pass

func _data(code,data):
	
	if code == "march":
		soldierNode.destination = data
	
	if code == "start_combat":
		stateMachine._set_state("start_combat",data,combatState)
	pass
