extends Area2D
class_name SelectedNode

var team_number = 0
var range : int = 120

@onready var collisionshape:CollisionShape2D = $CollisionShape2D

signal signal_target_selected(army)

func _ready():
	collisionshape.shape.radius = range
	pass
	
func _process(delta):
	# Meget vigtigt IKKE AT kolidere hvis SELECTION ikke ses
	# .... så kan TRYK PÅ hær indenfor området aktivere signal der sender pilen fra bueskytterne
	# .... 
	$CollisionShape2D.disabled = !visible	

	
func _draw():
	draw_arc(Vector2.ZERO,range,0,2*PI,100,Color.LIME,3)


func _in_range(p:Vector2):
	return (p-global_position).length() < range


func _on_area_entered(area):
	print("area enetered range area")
	if area is Army and area.team_number != team_number:
		var army : Army = area
		army.army_selected.connect(_target_selected_signal_recived)
		print("add new army to range area!")
	pass


func _on_area_exited(area):
	if area is Army and area.team_number != team_number:
		var army : Army = area
		army.army_selected.disconnect(_target_selected_signal_recived)
	pass

func _target_selected_signal_recived(army:Army):
	emit_signal("signal_target_selected",army)
	pass

