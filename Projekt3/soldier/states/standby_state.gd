##############################################################################
# SOLDIER - STANDBY STATE 						 							 #
##############################################################################
##############################################################################
extends Super_state
class_name soldier_standby_state

var stateMachine;
var marchState;
var combatState;
var soldierNode;
var grafikNode;
var animationNode;
var standbyState;

func _ready():
	stateMachine	= $".."
	marchState		= $"../march_state"
	combatState		= $"../combat_state"
	grafikNode		= $"../../Graphics"
	animationNode	= $"../../Graphics/AnimationPlayer"
	soldierNode		= $"../.."
	standbyState	= $"../standby_state" # denne reference er for de andre scripts ... lidt underligt
	pass

###############################################################################

func _start(code, data):
	pass
	
func _run():
	pass

func _data(code,data):
	if code == "march":
		stateMachine._set_state("march",data,marchState)

	if code == "start_combat":
		stateMachine._set_state("start_combat",data,combatState)
	pass
