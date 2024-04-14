extends Area2D
class_name Army

@export var team_number = 0

var velocity : Vector2
var destination : Vector2
var fighting = false

signal army_selected(army)
signal army_done(army)

func _ready():
	$Label.text = name
	$SelectedNode.visible		= false
	$SelectedNode.team_number	= team_number
	destination 			= global_position
	if team_number == 1 : $ArmySprite.self_modulate = Color.INDIGO
	if team_number == 2 : $ArmySprite.self_modulate = Color.DARK_CYAN
	if team_number == 3 : pass	
	pass
	
func _process(delta):
	var m = (destination - global_position)
	
	if m.length() > 2: 		
		velocity = m.normalized()
		global_position += velocity
		
	elif velocity.length() != 0:
		velocity = Vector2.ZERO
		# DONE SIGNAL : hæren har nået sin destination og skal ikke i kamp
		if  not fighting: emit_signal("army_done", self) 
		
	pass
	
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"): emit_signal("army_selected",self)
	pass

func _on_area_entered(area):
	
	if area is Army:
		destination = global_position - 5*velocity
		if area.team_number != team_number:
			$AnimationPlayer.play("explode")
			fighting = true
	
	if area is Arrow and area.team_number != team_number:
		$AnimationPlayer.play("explode")
		print("Argghhhj  der er nogen der skyder")
		area.queue_free()
	pass

func _on_animation_player_animation_finished(anim_name):
	fighting = false
	# DONE SIGNAL : hæren er færdig med kampen 
	emit_signal("army_done",self)
	pass

func _in_range(p:Vector2):
	return $SelectedNode._in_range(p)
	pass
	
func _set_destination(d:Vector2):
	if $SelectedNode.visible and $SelectedNode._in_range(d):
		if (d-global_position).length() > 5: 
		# FLYTTER IKKE NUL LÆNGDE! ellers bliver velocity 0,0 og programmet fejler
			destination = d
			_set_selected(false)
	pass

func _set_selected(s:bool):
	print(name, " selected = ", s)
	$SelectedNode.visible = s
	pass

func _is_selected():
	return $SelectedNode.visible
	pass
