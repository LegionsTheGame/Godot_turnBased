extends Sprite2D


func _ready():
	z_index = -100

func _draw():
	draw_circle(Vector2.ZERO,60,Color.DARK_BLUE)

