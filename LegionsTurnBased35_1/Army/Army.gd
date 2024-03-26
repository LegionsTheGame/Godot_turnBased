extends Area2D

class_name Army

export var team_id : int = 0

var destination : Vector2;
var selected : bool = false;
var team_color : Color;

func _ready():
	if team_id != 0:
		team_color = Color.brown
	else:
		team_color = Color.cyan
		
	destination 			= global_position
	$army_sprite.self_modulate	= team_color
	$range_sprite.visible		= false
	$destination.visible		= false
	
	
	pass

	
func _process(delta):
	var l = destination - global_position;
	#Bevæger hæren : hvis detinationen er forskellig fra global position
	if 	l.length() > 1:
		$status_label.text = "active"
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
		$army_sprite.self_modulate	= team_color
		$range_sprite.visible		= false
		$destination.visible		= false
		selected 					= false
		return true
	pass

		
func _select(pos):
	var l = pos - global_position;
	if l.length() < 10:
		$army_sprite.self_modulate	= Color.chocolate
		$range_sprite.visible		= true
		$destination.visible		= true
		selected 					= true
		return true;
	pass


func _deSelect(pos):
	var l = pos - global_position;
	if l.length() < 10:
		$army_sprite.self_modulate	= team_color
		$range_sprite.visible		= false
		$destination.visible		= false
		selected 					= false
		return true;
	pass


func _on_Army_area_entered(area):
	if area.get_class() == "Army":
		print("hit army with team_id:",area.team_id)
	
		if area.team_id != team_id:
			$status_label.text = "WAR!!"	
		else:
			$status_label.text = "sorry";
	
	destination = global_position
	pass # Replace with function body.

func get_class():
	return "Army"
