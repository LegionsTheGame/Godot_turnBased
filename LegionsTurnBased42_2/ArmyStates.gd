# ArmyStates

extends Area2D
class_name ArmyStates

enum { READY, SELECTED , MOVEING , FIGHTING, SHOOTING, DONE_SIGNAL, DONE }
var state = READY

func set_ready():		state = READY
func is_ready():		return state == READY

func set_selected():	state = SELECTED
func is_selected():		return state == SELECTED

func is_moveing():		return state == MOVEING

func set_fighting():	state = FIGHTING
func is_fighting():		return state == FIGHTING

func set_done():		state = DONE
func is_done():			return state == DONE

