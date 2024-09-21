extends Node2D

var soldiers = []
@export var team_code = 0
@export var soldierScene: PackedScene = preload("res://soldier/SoldierScene.tscn")

func _ready():
	
	for i in range(25):
		var s = soldierScene.instantiate();
		#print("set teamcode on soldier")
		s.position = Vector2((i%5)*25-50, (i/5)*25-50)
		print(i*-50 +50,"...", i*-50 +50)
		s.team_code = team_code
		s.get_node("Area2D").team_code = team_code
		s.local_army_position = s.position
		soldiers.append(s)
		add_child(s)
	pass


func _march_to(destination):
	for s in soldiers:
		s._march_to(destination+s.local_army_position)
		pass
	pass


func _process(delta):
	pass
