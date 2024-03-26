extends Node2D

var armyList1 = []
var armyList2 = []

var selectedArmy : Army = null;

func _ready():
	armyList1 = $startNode1.get_children()
	pass
	
func _process(delta):
	pass
	
func _input(event):	
	if Input.is_action_just_pressed("mouseLeft"):
		_mouse_input()
	pass


func _mouse_input():
	#Musens position huskes!!	
	var mousePosition = get_global_mouse_position()
	# Ingen Army er valgt : Forsøger vi at vælge en !!!
	if selectedArmy == null:
		for army in armyList1:
			if army._select(mousePosition): 
				selectedArmy = army; 
				break;
	# Army valgt og "Den vælges igen" : Deselectes den , dvs. selectedarmy sættes null
	elif selectedArmy._deSelect(mousePosition):
		selectedArmy = null
	# Army valgt og "Ny gyldig destination vælges" : Deselectes den, dvs. selectedarmy sættes null
	elif selectedArmy._set_destination(mousePosition):
		selectedArmy = null;
	pass;
