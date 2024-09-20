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
		#først drejes grafik-delen imod fjenden
		var dir = soldierNode.enemy.position - soldierNode.position
		grafikNode.rotation = dir.angle()
		#så "attack" animationen
		animationNode.play("attack")
		#Efter slutningen af hver animation regnes det ud,- hvem der dør...
		if animationNode.current_animation_position > animationNode.current_animation_length-0.01:
			print("attack animation ending...")
	pass

func _data(code,data):
		
	if code == "start_combat":
		var area2d = data #data er det area2d soldaten ramte
		## Hvis der allerede er en som soldaten slås imod ... kan den ikke slås imod flere
		if soldierNode.enemy != null: return 
		## Hvis den ikke slås ... vil den gemme enemy og slås imod den hvis den er en anden team_code
		var other = area2d.get_parent()
		if other.team_code != soldierNode.team_code:
			soldierNode.enemy = other

	if code == "stop_combat":
		var area2d = data #data er det area2d soldaten ramte
		var other = area2d.get_parent()
		if other == soldierNode.enemy:
			print("stop_combat")
			soldierNode.enemy = null
			stateMachine._set_state("",null,standbyState)
			
	if code == "march":
		stateMachine._set_state("march",data,marchState)
	pass
