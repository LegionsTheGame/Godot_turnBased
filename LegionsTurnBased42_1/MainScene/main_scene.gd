extends Node2D
class_name MainScene

var army_list : Array		= []
var army_in_progress : Army	= null 

func _ready():
	army_list 		= $Armies.get_children()
	for a in army_list:
		a.army_selected.connect(_on_army_signal_recived)
		a.army_done.connect(_on_army_done_signal_recived)
	pass

func _input(event):

	if event.is_action_pressed("mouse_left") and army_in_progress != null and army_in_progress._is_selected():
		
		var mpos = get_global_mouse_position()
		
		if army_in_progress._in_range(mpos):
			army_in_progress._set_destination(mpos)

		else:
			army_in_progress._set_selected(false)
			army_in_progress = null
				
	pass

func _on_army_signal_recived(army:Army):

	if army_in_progress == null:
		army_in_progress = army
		army_in_progress._set_selected(true)
	pass

func _on_army_done_signal_recived(army:Army):
	army_in_progress = null
	pass
