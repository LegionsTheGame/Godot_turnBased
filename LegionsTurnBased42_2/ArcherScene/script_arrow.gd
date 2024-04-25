extends Area2D
class_name Arrow

var target : Army
var destination : Vector2 

signal arrowHitTarget

func _ready():
	destination = global_position
	pass

func _process(delta):
	var L = destination - global_position
	if L.length() > 5:
		global_position += L.normalized()*4
	pass

func _on_area_entered(area):
	if area == target:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var attack  = rng.randi_range(0,6)
		print("arrow hit : ", attack<3)
		if(attack > 3):
			area.health -= 1
		emit_signal("arrowHitTarget")
		queue_free()
	pass


func set_destination(army : Army):
	target = army
	destination = army.global_position
	pass
	

