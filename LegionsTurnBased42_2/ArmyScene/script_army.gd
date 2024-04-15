extends Area2D
class_name Army

@export var team_number : int = 0

@onready var animationplayer : AnimationPlayer = $AnimationPlayer

@onready var destination : Vector2	= global_position
@onready var velocity : Vector2		= Vector2.ZERO	

enum { READY, SELECTED , MOVEING , FIGHTING, DONE }
var state = READY

signal signalSelected(army)
signal signalDone(army)


func _process(delta):
	var L = (destination - global_position)
		
	if state == READY:
		$MoveArea.visible	= false

	if state == SELECTED:
		$MoveArea.visible	= true
		if L.length() > 5 : state = MOVEING

	if state == MOVEING:
		$MoveArea.visible = false
		if L.length() > 5 :	
			global_position += velocity
			velocity = L.normalized()
		else: 				
			velocity = Vector2.ZERO
			state = DONE
			emit_signal("signalDone",self)
	
	if state == FIGHTING:
		velocity 	= Vector2.ZERO
		destination = global_position
		
	$Label.text = str(state)
	pass
	
	
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"):
		emit_signal("signalSelected",self)
		pass
	pass
	
func _on_area_entered(area):
	if area is Army:
		global_position -= 3*velocity
		$AnimationPlayer.play("explotion")
		if area.is_moveing(): area.set_fighting()
	pass

func _on_animation_player_animation_finished(anim_name):
	if is_fighting():
		state = DONE
		emit_signal("signalDone",self)
	pass
	
func set_destination(p:Vector2):
	if $MoveArea.inside(p):
		destination = p
	else:
		state = READY

func set_ready():		state = READY
func is_ready():		return state == READY

func set_selected():	state = SELECTED
func is_selected():		return state == SELECTED

func is_moveing():		return state == MOVEING

func set_fighting():	state = FIGHTING
func is_fighting():		return state == FIGHTING

func is_done():			return state == DONE
