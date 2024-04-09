extends Area2D

class_name ArmyScene

export var army_color	= Color.chartreuse
export var team_id		= 0

onready var range_scene : RangeScene			= $RangeScene
onready var army_sprite : Sprite				= $ArmySprite
onready var target_sprite :Sprite				= $TargetSprite
onready var animation_player: AnimationPlayer	= $AnimationPlayer
onready var label : Label						= $Label
onready var soundExp : AudioStreamPlayer2D		= $AudioExp

var life : int						= 3
var army_size : int					= 16
var selected : bool					= false
var target_to_attack : ArmyScene	= null
var enemies_touch_list 				= []
var destination : Vector2

enum STATE { IDLE, MARCHING , FIGHTING , DEAD}
var currentState 					= STATE.IDLE
var statesCompleted					= []

signal kill_signal(army)

func _ready():
	_set_selection(false)
	_set_as_target(false)
	_set_destination(global_position)
	army_sprite.self_modulate	= army_color
	range_scene.team_id 		= self.team_id
	statesCompleted.append(currentState)
	pass

func _process(delta):
	## ER enheden færdig med sin tur?
	# Vigtig den står først - hvis attack ikke skal ændres til IDLE med det samme
	if 	statesCompleted[statesCompleted.size()-1] != currentState:
		statesCompleted.append(currentState);
		pass
	
	# LOGIK, der flytter enheden ....
	var v = global_position - destination
	if v.length() > 2:
		# MARCHING tilstand hvis enheden ikke er ved destination
		global_position = global_position - v.normalized()
		currentState 	= STATE.MARCHING
	elif target_to_attack == null or not target_to_attack.animation_player.is_playing():
		#Der vælges kun IDLE state hvis angrebet er forbi
		currentState 	= STATE.IDLE
	
	## Label info
	var sc = ""
	for s in statesCompleted:
		sc = sc + str(s)	
	label.text = sc
	
	pass

func _is_army_position(global_selected_position : Vector2):
	var v = global_selected_position - global_position
	if v.length() < army_size/2: 
		return true
	pass
	
func _set_selection(select : bool):
	selected				= select
	range_scene._show_range(select)
	pass
			

func _set_as_target(is_target : bool):
	target_sprite.visible = is_target
	pass

func _start_explotion():
	animation_player.play("Explotion")
	soundExp.play()
	life = life -1
	if life == 2 : $life3.visible = false
	if life == 1 : $life2.visible = false
	if life == 0 : $life1.visible = false
	if life ==-1 : 
		emit_signal("kill_signal",self)
	pass

func _set_destination(new_destination: Vector2):
	var valid_move =  range_scene._is_inside(new_destination)
	if valid_move:
		destination = new_destination;
	return valid_move
	pass

func _set_attack_destination(new_destination: Vector2):
	target_to_attack = range_scene._get_attack_target(new_destination)
	for a in enemies_touch_list:
		if a == target_to_attack:
			var t = target_to_attack
			if t.life == 0 : target_to_attack = null 
			t._start_explotion()
			destination = global_position
			currentState = STATE.FIGHTING
	pass


func get_class():
	return "ArmyScene"
	
	
func _on_Army_area_entered(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_touch_list.append(area)
		destination = global_position
		if target_to_attack == area:
			target_to_attack._start_explotion()
			currentState = STATE.FIGHTING
		pass
	pass


func _on_Army_area_exited(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_touch_list.erase(area)
	pass
