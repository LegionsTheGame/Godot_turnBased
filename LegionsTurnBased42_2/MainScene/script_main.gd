extends Node2D
class_name Main

var team0 	= []
var armyInFocus :Army	= null


func _ready():
	team0 	= $HumanTeam.get_children()
	for a in team0:
		a.signalSelected.connect(_recived_army_selected)
		a.signalDone.connect(_recived_army_done)
	pass


func _input(event):
	if armyInFocus != null and armyInFocus.is_selected() and event.is_action_pressed("mouse_left"):
		armyInFocus.set_destination(get_global_mouse_position())
	pass


func _recived_army_selected(army:Army):
	#print("A selected : ", army, " armyInFocus : ", armyInFocus)
	# Det er lidt indviklet hvornår man må vælge en ny hær!!
	# .... dette kan forbedres
	# .... måske behøver man ikke at sætte armyInFocus til null
	if (army.is_ready() and armyInFocus == null) or (army.is_ready() and armyInFocus != null and armyInFocus.is_ready()):
		armyInFocus = army
		armyInFocus.set_selected()
	#print("B selected : ", army, " armyInFocus : ", armyInFocus)
	pass


func _recived_army_done(army:Army):
	if army == armyInFocus:
		armyInFocus = null
		pass
	pass


func _on_reset_turn_button_down():
	for a in team0:
		a.set_ready();
	pass
