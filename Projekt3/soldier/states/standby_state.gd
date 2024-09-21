##############################################################################
# SOLDIER - STANDBY STATE 						 							 #
##############################################################################
##############################################################################
extends Super_state
class_name soldier_standby_state

var grafikNode;
var animationNode;
var soldierNode;
var stateMachine;
var standbyState;
var marchState;
var combatState;
var deadState;

func _ready():
	
	grafikNode		= $"../../Graphics"
	animationNode	= $"../../Graphics/AnimationPlayer"
	soldierNode		= $"../.."
	
	stateMachine	= $".."
	marchState		= $"../march_state"
	standbyState	= $"../standby_state" # denne reference er for de andre scripts ... lidt underligt
	combatState		= $"../combat_state"
	deadState		= $"../dead_state"
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
	
	if code == "dead":
		stateMachine._set_state("dead",null,deadState)
	pass
