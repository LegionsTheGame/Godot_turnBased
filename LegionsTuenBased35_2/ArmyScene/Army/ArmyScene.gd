extends Area2D

class_name ArmyScene

onready var army_sprite : Sprite	= $ArmySprite
onready var move_area : RangeScene	= $Range
onready var target_sprite :Sprite	= $TargetSprite
onready var label : Label			= $Label

var selected : bool			= false
var army_size : int			= 16
var destination : Vector2

func _ready():
	_set_selection(false)
	_set_as_target(false)
	_set_destination(global_position)
	pass

func _process(delta):
	var v = global_position - destination
	if v.length() > 2:
		global_position = global_position - v.normalized()

func _is_army_position(global_selected_position : Vector2):
	var v = global_selected_position - global_position
	if v.length() < army_size: return true
	pass
	
func _set_selection(select : bool):
	move_area.visible 		= select
	selected				= select
	pass
			
func _set_as_target(is_target : bool):
	target_sprite.visible = is_target
	pass

func _set_destination(new_destination: Vector2):
	var valid_move =  move_area._is_inside(new_destination)
	if valid_move:
		destination = new_destination;
	return valid_move
	pass
