# STATE - CLASS
extends Node2D
class_name State
###############################
enum modes{READY_MODE, PROCESS_MODE, TRANS_MODE}
var mode = modes.READY_MODE

func run(delta):
	get_parent().get_node("Label").text = name + " : " + modes.keys()[mode]
	if mode == modes.READY_MODE:		readyMode()
	elif mode == modes.PROCESS_MODE:	processMode(delta)
	elif mode == modes.TRANS_MODE:		transMode()
pass
###############################
func readyMode(): 			setProcess()
func processMode(delta):	pass
func transMode():			pass
###############################
func setData(data):			pass
################################
func setReady(): 			mode = modes.READY_MODE
func setProcess():			mode = modes.PROCESS_MODE
func setTrans():			mode = modes.TRANS_MODE
################################
func moveRadius(): 			return get_parent().moveRadius
func armyRadius(): 			return get_parent().armyRadius
func distToMouse():			return (global_position - get_global_mouse_position()).length()
func moveAreaVisible(v):	get_parent().get_node("MoveArea").visible = v

func setState(s,data=null):
	if data != null : s.setData(data)
	mode = modes.READY_MODE
	get_parent().state = s  

################################	
func armyCollision(a):
	if a is Army:
		var defendState = $"../stateDefend" 
		setState(defendState)
	pass
################################
