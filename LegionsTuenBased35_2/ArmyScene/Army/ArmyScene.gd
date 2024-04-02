extends Area2D

class_name ArmyScene

export var army_color	= Color.chartreuse
export var team_id		= 0

onready var range_scene : RangeScene			= $RangeScene
onready var army_sprite : Sprite				= $ArmySprite
onready var target_sprite :Sprite				= $TargetSprite
onready var animation_player: AnimationPlayer	= $AnimationPlayer
onready var label : Label						= $Label

var army_size : int					= 16
var selected : bool					= false
var target_to_attack : ArmyScene	= null
var enemies_touch_list 				= []
var destination : Vector2


func _ready():
	_set_selection(false)
	_set_as_target(false)
	_set_destination(global_position)
	army_sprite.self_modulate	= army_color
	range_scene.team_id 		= self.team_id
	#animation_player.play("Explotion")
	update_label()
	pass

func _process(delta):
	var v = global_position - destination
	if v.length() > 2:
		global_position = global_position - v.normalized()

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
			print("next to attack")
			target_to_attack._start_explotion()
			destination = global_position
	pass


func get_class():
	return "ArmyScene"
	
	
func _on_Army_area_entered(area):
	
	
	
	
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_touch_list.append(area)
		destination = global_position
		update_label()
		
		if target_to_attack == area:
			target_to_attack._start_explotion()
		
		pass
	pass


func _on_Army_area_exited(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_touch_list.erase(area)
		update_label()
	pass


func update_label():
	label.text = "touching: " + str(enemies_touch_list.size())
	pass
