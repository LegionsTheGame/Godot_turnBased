extends Sprite2D

var soldier_node

func _ready():
	soldier_node = $"../.."
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var radius = 30 
	if soldier_node.leader : radius = 60
	if soldier_node.king_code == 0:
		draw_circle(Vector2.ZERO,radius,Color.AQUA)
	elif soldier_node.king_code == 1:
		draw_circle(Vector2.ZERO,radius,Color.BLUE_VIOLET)
	elif soldier_node.king_code == 2:
		draw_circle(Vector2.ZERO,radius,Color.CHARTREUSE)
