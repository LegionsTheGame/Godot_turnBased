extends Area2D

class_name RangeScene

export var team_id = 0;

var radius : int 	= 126
var enemies_inside_list	= []

func _process(delta):
	update_label()
	pass

func _show_range(showit:bool):
	visible = showit
	_show_targets(showit)
	pass

func _is_inside(position:Vector2):
	var v = global_position - position
	if v.length() < radius + 10:
		return true 
	pass

func _on_Range_area_entered(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		enemies_inside_list.append(area)
	_show_targets(visible)	
	pass

func _on_Range_area_exited(area):
	if area.get_class() == "ArmyScene" and area.team_id != self.team_id:
		area._set_as_target(false)
		enemies_inside_list.erase(area)
	pass

func _get_attack_target(target:Vector2):
	for a in enemies_inside_list:
		var l : Vector2 = a.global_position - target
		if l.length() < a.army_size/2:
			return a;
	pass

func update_label():
	$Label.text = "team:" + str(team_id) + "\n inside: " + str(enemies_inside_list.size())
	pass
	
func _show_targets(showtarget):
	for a in enemies_inside_list:
		a._set_as_target(showtarget)
	pass

