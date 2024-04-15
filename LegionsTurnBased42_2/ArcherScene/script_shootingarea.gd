extends Area2D
class_name ShootingArea

var team_number : int = 0

var enemies	= []
var radius = 200

signal signalEnemyTargetSelected(army)

func _ready():
	$CollisionShape2D.shape.radius = radius
	pass

func _draw():
	draw_arc(Vector2.ZERO,radius,0,2*PI,100,Color.LIME,3)

func inside(p:Vector2):
	var L = (p-global_position).length()
	return L < radius

func _on_area_entered(area):
	if area is Army and area.team_number != team_number:
		enemies.append(area)
		area.signalSelected.connect(_enemy_target_selected)
		print("NEW ARMY IN SHOOTING AREA")
	pass

func _on_area_exited(area):
	enemies.erase(area)
	pass

func _enemy_target_selected(army:Army):
	if get_parent().visible:
		emit_signal("signalEnemyTargetSelected",army)
	pass
