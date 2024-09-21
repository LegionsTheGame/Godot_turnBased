##############################################################################
# COMBAT STATE 									 							 #
##############################################################################
extends soldier_standby_state 	#forsøg på at genbruge variabler
###############################################################################

func _start(code, data):
	_data(code,data)
	pass
	
func _run():
	if soldierNode.enemy != null:
		#print("running combat state")
		#først drejes grafik-delen imod fjenden
		var dir = soldierNode.enemy.global_position - soldierNode.global_position
		grafikNode.rotation = dir.angle()
		#så "attack" animationen
		animationNode.play("attack")
		#Efter slutningen af hver animation regnes det ud,- hvem der dør...
		if animationNode.current_animation_position > animationNode.current_animation_length-0.01:
			var r = RandomNumberGenerator.new().randf_range(0,100)
			if r < 40:
				soldierNode.enemy.get_parent()._kill()
				soldierNode.enemy = null
				stateMachine._set_state("",null,standbyState)
			pass
	pass

func _data(code,data):
		
	if code == "start_combat":
		#print("combat state:", data.team_code, soldierNode.team_code)
		soldierNode.enemy = data
		#print("ny enemy:",soldierNode.enemy,data)
		#if soldierNode.enemy == null:

	if code == "stop_combat":
		if data == soldierNode.enemy:
			soldierNode.enemy = null
			stateMachine._set_state("",null,standbyState)
			
	if code == "march":
		stateMachine._set_state("march",data,marchState)
	
	if code == "dead":
		stateMachine._set_state("dead",null,deadState)
	pass
