extends Sprite2D


func _ready():
	pass


func _process(delta):
	pass


func _draw():
	if get_parent().get_parent().team_code == 0:	
		draw_circle(Vector2.ZERO,5,Color.AQUA)
	if get_parent().get_parent().team_code != 0:
		draw_circle(Vector2.ZERO,5,Color.BLUE)		
	pass
