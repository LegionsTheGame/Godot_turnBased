extends Node2D

var soldiers = []
@export var team_code = 0

func _ready():
	for s in get_children():
		#print("set teamcode on soldier")
		s.team_code = team_code
		s.get_node("Area2D").team_code = team_code
		s.local_army_position = s.position
		soldiers.append(s)
	pass


func _march_to(destination):
	for s in get_children():
		s._march_to(destination+s.local_army_position)
		pass
	pass


func _process(delta):
	pass
