# script_army.gd
extends ArmyStates
class_name Army

@export var team_number : int = 0

@onready var animationplayer : AnimationPlayer = $AnimationPlayer

@onready var destination : Vector2	= global_position
@onready var velocity : Vector2		= Vector2.ZERO	

var health = 4
var attack_strength 	= 3
var deffend_strength 	= 2

signal signalSelected(army)
signal signalDone(army)
signal signalDead(army)

var changeColor = false
var army_color : Color

func _ready():
	print("army ready")
	set_army_color()
	pass


func _process(delta):
	var L = (destination - global_position)
		
	if is_dead():
		set_process_input(false)
		$CollisionShape2D.disabled = true
		$ArmySprite.visible = false
		return
		pass
		
	if is_ready():
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position
		if changeColor:
			set_army_color()
			changeColor = false;

	if is_selected():
		$MoveArea.visible = true
		velocity 	= Vector2.ZERO
		if L.length() > 1 : 
			set_moveing()
		if changeColor:
			set_army_color()
			changeColor = false;

	if is_moveing():
		$MoveArea.visible = false
		if L.length() > 1 :	
			global_position += velocity
			velocity = L.normalized()*2
		else: 				
			velocity = Vector2.ZERO
			set_done_signal()
	
	if is_attacking():
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position
		# Næste state bliver sat når eksplotionen er færdig
		
	if is_done_signal():
		$MoveArea.visible = false
		velocity 	= Vector2.ZERO
		destination = global_position
		emit_signal("signalDone",self)
		set_done()
	
	if is_done():
		$MoveArea.visible = false	
		velocity = Vector2.ZERO
		if changeColor:
			set_army_color(0.5)
			changeColor = false;	

			
	if health < 0 and not is_dead():
		set_dead()
		emit_signal("signalDead", self)
	
	$Label.text = str(health) #str(state) + "/" + str(health)
	pass
	
	
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"):
		emit_signal("signalSelected",self)
		pass
	pass
	
func _on_area_entered(area):
	#print(area.state, area.velocity)
	#Tvinger alle enheder til at have en afstand uden overlap
	if area is Army:
		var d : Vector2 = area.global_position - global_position
		if d.length() < $CollisionShape2D.shape.radius*2:
			global_position = area.global_position - d.normalized()*21
	
		if area.team_number != team_number:
				if is_moveing() : 
					$AnimationPlayer.play("explotion")
					set_attacking()
					calculate_casualties(area)
				elif area.is_moveing() or area.is_attacking(): 
					$AnimationPlayer.play("explotion")
					last_state = state
					set_defending()
		if area.team_number == team_number and is_moveing(): 
			set_done_signal()

	pass


func calculate_casualties(enemy:Army):
	if is_attacking():
		print("ATTACK CALCULATIONS");
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var attack  = rng.randi_range(0,attack_strength)
		var deffend = rng.randi_range(0,enemy.deffend_strength)
		print("Attack: " + str(attack) + " Defend: " + str(deffend))
		if(attack > deffend ):
			enemy.health -= 1;
		else:
			health -= 1
		pass
	pass

func _on_animation_player_animation_finished(anim_name):
	if is_attacking():
		set_done_signal()
	if is_defending():
		state = last_state
		pass
	pass
	
	
func set_destination(p:Vector2):
	if $MoveArea.inside(p):
		destination = p
		return true
	else:
		set_ready()
		return false


func set_ready():
	changeColor = true;
	print(self.name, " ready change color time!")
	super.set_ready();
	pass


func set_done():
	changeColor = true;
	print(self.name, " done change color time!")
	super.set_done();
	pass


func set_army_color(v=1):
	if team_number == 0:	$ArmySprite.self_modulate = Color(v,0,0)
	if team_number == 1:	$ArmySprite.self_modulate = Color(0,v,0)
	if team_number == 2:	$ArmySprite.self_modulate = Color(0,0,v)
	
func set_army_team(t):
	team_number = t
	set_army_color()
