extends "res://Army/Army.gd"

var health = 3
var attack = 6
var armor  = 4

func _ready():
	_update_status()
	pass

func _process(delta):
	pass

func _touch_enemy(enemy : Army):
	_update_status()
	pass

func _leave_enemy(enemy : Army):
	_update_status()	
	pass

func _update_status():
	var nE = str(enemyContactList.size())
	var nH = str(health)
	$status_label.text="health="+nH+" enemies="+nE
