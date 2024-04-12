extends Area2D
class_name Army

var velocity : Vector2
var destination : Vector2
var fighting = false

signal army_selected(army)
signal army_done(army)

func _ready():	
	destination = global_position
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
	if Input.is_action_just_pressed("mouse_left"): emit_signal("army_selected",self)
	pass

func _on_area_entered(area):
	if area is Army:
		destination = global_position - 5*velocity
		$AnimationPlayer.play("explode")
		fighting = true
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
		destination = d
		_set_selected(false)
	pass

func _set_selected(s:bool):
	$SelectedNode.visible = s
	pass

func _is_selected():
	return $SelectedNode.visible
	pass
