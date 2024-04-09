extends Area2D
class_name Army

@onready var army_sprite : Sprite2D		= $ArmySprite
@onready var selected_sprite :Sprite2D	= $ArmySelectedSprite 

var destination : Vector2

signal army_selected(army)

func _ready():	
	destination = global_position
	pass

func _process(delta):
	var m = (destination - global_position)
	if m.length() > 2: global_position += m.normalized()
	pass

func _set_destination(d:Vector2): 
	destination = d
	pass

func _set_selected(s:bool):
	selected_sprite.visible = s
	pass

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		print("army_clicked");
		emit_signal("army_selected",self)
	pass
