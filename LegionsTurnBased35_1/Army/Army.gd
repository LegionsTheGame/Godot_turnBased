extends Area2D

class_name Army

export var team_id : int	= 0

var selected : bool			= false;
var enemyContactList 		= []
var destination : Vector2;	

func _ready():
	if team_id != 0: $army_sprite.self_modulate = Color.brown; else: $army_sprite.self_modulate = Color.cyan		
	destination 				= global_position
	_select_and_update_ui(false)
	pass

	
func _process(delta):
	var l = destination - global_position;
	#Bevæger hæren : hvis detinationen er forskellig fra global position
	if 	l.length() > 1:
		global_position = global_position + l.normalized()
	#Grafik der markerer om den valgte destination er gyldig!!
	if selected:
		var l2 = global_position - get_global_mouse_position();
		if l2.length()<130:
			$destination.global_position = get_global_mouse_position();
			$destination.self_modulate = Color(0,1,0,0.4)
		else:
			$destination.self_modulate = Color(1,0,0,0.4)
		pass
	
	pass
	
		
func _set_destination(new_destination):
	var l = new_destination - global_position;
	if l.length()<150:
		destination = new_destination
		_select_and_update_ui(false)
		return true
	pass

		
func _select(pos):
	var l = pos - global_position;
	if l.length() < 10:	
		_select_and_update_ui(true); 
		return true;


func _deSelect(pos):
	var l = pos - global_position;
	if l.length() < 10:	
		_select_and_update_ui(false); 
		return true;


func _on_Army_area_entered(area):
	destination = global_position
	if area.get_class() == "Army" and area.team_id != team_id:
			enemyContactList.append(area)
			_touch_enemy(area)
	pass
	

func _on_Army_area_exited(area):
	if area.get_class() == "Army" and area.team_id != team_id:
			enemyContactList.erase(area)
			_leave_enemy(area)
	pass
	
## HELPER FUNKTIONER - FOR DETTE SCRIPT...	
	
func _select_and_update_ui(select:bool):
		$range_sprite.visible		= select	# sprite der viser hvor langt enheden kan rykke
		$destination.visible		= select	# sprite der markerer gyldige "muse-positioner"
		selected					= select


		
func get_class():
	return "Army"

### FUNKTIONER DER SKAL IMPLEMENTERES I SUB-KLASSER : INFANTARI, BUESKYTTER OG KAVALLERI

func _touch_enemy(enemy : Army): print("Basic Army Battle!");		pass

func _leave_enemy(enemy : Army): print("Basic Army Left Battle!");	pass
