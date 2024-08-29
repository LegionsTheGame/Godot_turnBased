extends Area2D

@export var movable = true
# Called when the node enters the scene tree for the first time.
func _ready():
	print("now I am ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not movable:
		return
		
	if Input.is_action_pressed("a"):
		position.x = position.x-1
	if Input.is_action_pressed("d"):
		position.x = position.x+1

	pass



func _on_body_entered(body):
	print("OMG body entered")
	pass # Replace with function body.



func _on_area_entered(area):
	print("OMG area2d entered")
	pass # Replace with function body.


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("OMG area shape entered")
	pass # Replace with function body.


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("on body shape enetered")
	pass # Replace with function body.
