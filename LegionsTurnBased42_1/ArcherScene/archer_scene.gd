extends "res://ArmyScene/army_scene.gd"
class_name ArcherScene

@onready var arrow_scene = preload("res://ArcherScene/arrow_scene.tscn")

var possible_arrow = false;

func _ready():
	super._ready()
	$SelectedNode.signal_target_selected.connect(_signal_target_selected_recived)
	pass

func _signal_target_selected_recived(army:Army):
	print(name , " . har modtaget et signal om vi angriber ", army)
	destination = global_position
	var new_arrow : Arrow = arrow_scene.instantiate()
	new_arrow.global_position += Vector2(20,20)
	new_arrow.team_number = team_number
	# Når modstanderen bliver ramt sendes et done signal til main-scene og det er nu muligt at flytte den næste brik....
	# Ikke helt fornuftigt ... men sådan bliver det indtil videre...
	new_arrow._set_destination(army.global_position)
	add_child(new_arrow)
	pass
	
	

