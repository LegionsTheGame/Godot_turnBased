extends Area2D

class_name RangeScene

export var team_id = 0;

var radius : int 	= 126
var enemies_inside	= []

func _process(delta):
	update_label()
	pass

func _show_range(showit:bool):
	visible = showit
	_show_targets(showit)
	pass

func _is_inside(position:Vector2):
	var v = global_position - position
	if v.length() < radius:
		return true 
	pass

func _on_Range_area_entered(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_inside.append(area)
	_show_targets(visible)	
	pass

func _on_Range_area_exited(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		area._set_as_target(false)
		enemies_inside.erase(area)
	pass

func update_label():
	$Label.text = "team:" + str(team_id) + "\n enemies in: " + str(enemies_inside.size())
	pass
	
func _show_targets(showtarget):
	for a in enemies_inside:
		a._set_as_target(showtarget)
	pass

