extends Area2D

class_name ArmyScene

export var army_color	= Color.chartreuse
export var team_id		= 0

onready var army_sprite : Sprite		= $ArmySprite
onready var range_scene : RangeScene	= $Range
onready var target_sprite :Sprite		= $TargetSprite
onready var label : Label				= $Label

var selected : bool			= false
var army_size : int			= 16
var destination : Vector2

func _ready():
	_set_selection(false)
	_set_as_target(false)
	_set_destination(global_position)
	army_sprite.self_modulate	= army_color
	range_scene.team_id 		= self.team_id
	pass

func _process(delta):
	var v = global_position - destination
	if v.length() > 2:
		global_position = global_position - v.normalized()

func _is_army_position(global_selected_position : Vector2):
	var v = global_selected_position - global_position
	if v.length() < army_size: 
		return true
	pass
	
func _set_selection(select : bool):
	selected				= select
	range_scene._show_range(select)
	pass
			

func _set_as_target(is_target : bool):
	target_sprite.visible = is_target
	pass


func _set_destination(new_destination: Vector2):
	var valid_move =  range_scene._is_inside(new_destination)
	if valid_move:
		destination = new_destination;
	return valid_move
	pass


func get_class():
	return "ArmyScene"
	
	
func _on_Army_area_entered(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		destination = global_position
		pass
	pass


func _on_Army_area_exited(area):
	pass
