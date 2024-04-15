extends Node2D
class_name Main

var armies 				= []
var armyInFocus :Army	= null

func _ready():
	armies 				= $Armies.get_children()
	for a in armies:
		a.signalSelected.connect(_recived_army_selected)
		a.signalDone.connect(_recived_army_done)
	pass

func _input(event):
	if armyInFocus != null and armyInFocus.is_selected() and event.is_action_pressed("mouse_left"):
		armyInFocus.set_destination(get_global_mouse_position())
	pass

func _recived_army_selected(army:Army):
	if armyInFocus != null and not armyInFocus.is_ready() : return
	armyInFocus = army
	armyInFocus.set_selected()
	pass

func _recived_army_done(army:Army):
	armyInFocus = null
	pass


func _on_reset_turn_button_down():
	for a in armies:
		a.set_ready();
	pass
