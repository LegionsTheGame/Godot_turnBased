extends Area2D

class_name ArmyScene

onready var army_sprite : Sprite		= $ArmySprite
onready var move_area : RangeScene		= $Range
onready var target_sprite :Sprite		= $TargetSprite

var selected	= false
var army_size	= 16

func _ready():
	_set_selection(false)
	_set_as_target(false)
	pass

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
