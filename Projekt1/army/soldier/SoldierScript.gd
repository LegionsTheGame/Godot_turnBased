extends Node2D

var king_code = 0

var center_position
var vel = Vector2(0.1,0.1)

var dead = false

var enemies = []

func _ready():
	center_position = position
	pass # Replace with function body.


func _process(delta):
	#test dead from mouses
	if (get_global_mouse_position() - global_position).length() < Globals.mouse_radius:
		print("test mouse dead")
		_generatePercentDeadChance(20)
	
	
	if enemies.size() > 0:
		_generatePercentDeadChance(0.5)
		randomMoveFromCeneter(3)
		
	for s in enemies:
		if s.dead:
			enemies.erase(s)	
		
	pass

func _generatePercentDeadChance(percent):
	# dette er en random-død < 1% generator - for at teste den visuelle effekt
	if not dead:
		if not $AnimationPlayer.is_playing():
			var r = RandomNumberGenerator.new().randf_range(0, 1)
			if r < (percent/100.0):
				$AnimationPlayer.play("new_animation")
				dead = true
pass	




func randomMoveFromCeneter(l):
	var r = RandomNumberGenerator.new().randf_range(-PI/4, PI/4)
	vel = vel.rotated(r)
	var new_position = position + vel
	
	if (new_position - center_position).length() > l:
		vel = (center_position-position).limit_length(0.1)
		new_position = position + vel
	
	#print(center_position ,"   ", new_position.length())
	position = new_position
	
	pass
	


func _on_area_2d_area_entered(area):
	var other = area.get_parent()
		
	if not other.dead and king_code != other.king_code:
		enemies.append(other)
		print("start fight","...",other.king_code,"...",other.dead)
		pass
	pass


func _on_area_2d_area_exited(area):
	var other = area.get_parent()
	if other.king_code != king_code:
		enemies.erase(other)
		print("stop fight","...",other.king_code,"...", other.dead)
	
	pass
