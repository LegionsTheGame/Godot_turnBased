extends Node2D

var team0 	= []
var armyInFocus :Army	= null
var indexArmy = 0

signal signalHumanTurnFinished

func _ready():
	team0 	= get_children()
	for a in team0:
		a.signalSelected.connect(_recived_army_selected)
		a.signalDone.connect(_recived_army_done)
	selectNextFocusArmy()
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
	selectNextFocusArmy()
	print("human team done")
	pass

func _on_reset_human_turn_button_down():
	indexArmy = 0
	for a in team0:
		a.set_ready();
	pass

func selectNextFocusArmy():
	if indexArmy < team0.size():
		armyInFocus = team0[indexArmy]
		armyInFocus.set_selected()
		indexArmy +=1
	else:
		emit_signal("signalHumanTurnFinished")
	pass
