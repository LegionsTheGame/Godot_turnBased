extends "res://ArmyScene/army_scene.gd"

func _ready():
	super._ready()
	$ArmySprite.texture = load("res://ArcherScene/archer_sprite.png")
	pass
