# ArmyStates

extends Area2D
class_name ArmyStates

enum { READY, SELECTED , MOVEING , ATTACKING, DEFENDING, SHOOTING, DONE_SIGNAL, DONE , DEAD }

var state = READY
var last_state = READY

func set_ready():		state = READY
func is_ready():		return state == READY

func set_selected():	state = SELECTED
func is_selected():		return state == SELECTED

func set_moveing():		state = MOVEING
func is_moveing():		return state == MOVEING

func set_attacking():	state = ATTACKING
func is_attacking():		return state == ATTACKING

func set_defending():	state = DEFENDING
func is_defending():	return state == DEFENDING

func set_done_signal():	state = DONE_SIGNAL
func is_done_signal():	return state == DONE_SIGNAL

func set_done():		state = DONE
func is_done():			return state == DONE

func set_dead():		state = DEAD
func is_dead():			return state == DEAD
