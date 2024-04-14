extends "res://ArmyScene/selected_node.gd"




func _on_area_entered(area):
	print("area enetered range area")
	if area is Army and area.team_number != team_number:
		var army : Army = area
		army.army_selected.connect(_target_selected_signal_recived)
		print("add new army to range area!")
	pass
	
func _on_area_exited(area):
	if area is Army and area.team_number != team_number:
		var army : Army = area
		army.army_selected.disconnect(_target_selected_signal_recived)
	pass
