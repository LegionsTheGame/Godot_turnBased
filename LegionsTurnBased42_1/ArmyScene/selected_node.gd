extends Area2D

var team_number = 0
var range : int = 120

@onready var collisionshape:CollisionShape2D = $CollisionShape2D

func _ready():
	collisionshape.shape.radius = range
	pass
	
func _draw():
	draw_arc(Vector2.ZERO,range,0,2*PI,100,Color.LIME,3)


func _in_range(p:Vector2):
	return (p-global_position).length() < range



func _on_area_entered(area):
	if area is Army and area.team_number != team_number:
		print(self.get_parent().name ," .... army exit range area ..... ",area.name)
	pass



func _on_area_exited(area):
	if area is Army and area.team_number != team_number:
		print(self.get_parent().name ," .... army exit range area ..... ",area.name)
	pass
