##################
# SOLDIER SCRIPT #
##################
extends Node2D
class_name Soldier

#Levende eller død?! (starter som levende)
var dead : bool = false
# Dette er soldatens ønskede position - som den forsøger at bevæge sig til
var destination : Vector2
# Dette er soldatens lokale position i hæren - hvis hæren har heading 0 grader
var local_army_position : Vector2

# Fjende som soldaten kæmper imod - hver soldat kan kun slås med en anden soldat - dette er denne fjende
var enemy : Soldier
# Team nummer - det team som soldaten er på, så man kan kende forskel på fjender og venner
@export var team_code : int 


func _ready():
	destination = global_position
	pass


func _process(delta):
	#Soldaten bevæger sig altid imod et mål hvis der er et!
	_move_to_dest()
	
	# hvis der er en fjende startes "kamp"
	if enemy != null:
		#først drejes grafik-delen imod fjenden
		var dir = enemy.position - position
		$Graphics.rotation = dir.angle()
		#så "attack" animationen
		$Graphics/AnimationPlayer.play("attack")
		#Efter slutningen af hver animation regnes det ud,- hvem der dør...
		if $Graphics/AnimationPlayer.current_animation_position > $Graphics/AnimationPlayer.current_animation_length-0.01:
			print("attack animation ending...")
	pass


func _move_to_dest():
	var dist = destination - global_position
	if dist.length() > 1:
		position = position + dist.normalized()
	pass


func _on_area_2d_area_entered(area):
	# Hvis der allerede er en som soldaten slås imod ... kan den ikke slås imod flere
	if enemy != null: return 
	# Hvis den ikke slås ... vil den gemme enemy og slås imod den hvis den er en anden team_code
	var other = area.get_parent()
	if other.team_code != team_code:
		enemy = other
	pass


func _on_area_2d_area_exited(area):
	var other = area.get_parent()
	if other == enemy:
		enemy = null
	pass
