extends Area2D

var range : int = 120

@onready var collisionshape:CollisionShape2D = $CollisionShape2D

func _ready():
	collisionshape.shape.radius = range
	pass

func _in_range(p:Vector2):
	return (p-global_position).length() < range
	
func _draw():
	draw_arc(Vector2.ZERO,range,0,2*PI,100,Color.LIME,3)
