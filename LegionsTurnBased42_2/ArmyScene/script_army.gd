# script_army.gd
extends ArmyStates
class_name Army

@export var team_number : int = 0

@onready var animationplayer : AnimationPlayer = $AnimationPlayer

@onready var destination : Vector2	= global_position
@onready var velocity : Vector2		= Vector2.ZERO	

#enum { READY, SELECTED , MOVEING , FIGHTING, DONE_SIGNAL, DONE }
#var state = READY

signal signalSelected(army)
signal signalDone(army)

func _ready():
	if team_number == 0:
		$ArmySprite.self_modulate = Color.CHARTREUSE
	if team_number == 1:
		$ArmySprite.self_modulate = Color.GOLD
	if team_number == 2:
		$ArmySprite.self_modulate = Color.RED
	pass


func _process(delta):
	var L = (destination - global_position)
		
	if state == READY:
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position

	if state == SELECTED:
		$MoveArea.visible = true
		velocity 	= Vector2.ZERO
		if L.length() > 5 : 
			state = MOVEING

	if state == MOVEING:
		$MoveArea.visible = false
		if L.length() > 5 :	
			global_position += velocity
			velocity = L.normalized()
		else: 				
			velocity = Vector2.ZERO
			state = DONE_SIGNAL
	
	if state == ATTACKING:
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position
		# Næste state bliver sat når eksplotionen er færdig
		
	if state == DONE_SIGNAL:
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position
		emit_signal("signalDone",self)
		state = DONE
	
	if state == DONE:
		$MoveArea.visible = false	
		velocity = Vector2.ZERO
	
	$Label.text = str(state)
	pass
	
	
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"):
		emit_signal("signalSelected",self)
		pass
	pass
	
func _on_area_entered(area):
	#print(area.state, area.velocity)
	if area is Army and area.team_number != team_number:
			#global_position -= 3*velocity
			var d = area.global_position - global_position
			global_position -= d.normalized()*2
			#dette er forhindring af bump ind i krige
			if is_moveing() : 
				$AnimationPlayer.play("explotion")
				set_attacking()
			elif area.is_moveing() or area.is_attacking(): 
				$AnimationPlayer.play("explotion")
	if area is Army and area.team_number == team_number: # and is_moveing():
		#global_position -= 3*velocity
		var d = area.global_position - global_position
		global_position -= d.normalized()*2
		if is_moveing(): state = DONE_SIGNAL

	pass

func _on_animation_player_animation_finished(anim_name):
	if is_attacking():
		state = DONE_SIGNAL
	pass
	
func set_destination(p:Vector2):
	if $MoveArea.inside(p):
		destination = p
	else:
		state = READY
