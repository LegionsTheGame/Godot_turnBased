extends Sprite2D

var soldier_node

func _ready():
	soldier_node = $"../.."
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	if soldier_node.king_code == 0:
		draw_circle(Vector2.ZERO,30,Color.AQUA)
	elif soldier_node.king_code == 1:
		draw_circle(Vector2.ZERO,30,Color.BLUE_VIOLET)
	elif soldier_node.king_code == 2:
		draw_circle(Vector2.ZERO,30,Color.CHARTREUSE)
