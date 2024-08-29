extends Node2D

@export var king_code = 0
@export var userControled = false

var soldier_grid = []

func _ready():
	for i in range(8):
		soldier_grid.append([])
		soldier_grid[i].resize(10)
	
	
	print("hvor mange soldater er der: ",get_children().size())
	 
	var n = 0
	var r = 0
	var c = 0
	
	for soldier in get_children():
		r = n%8
		c = n/8
		#print("soldat r,c: ",r, " ",c)
		soldier.king_code = king_code
		soldier.position  		= Vector2(c*10,r*10);
		soldier.center_position	= Vector2(c*10,r*10);
		soldier_grid[r][c]=soldier 
		n = n + 1
		pass	
	pass


func re_formation(row,col):
	
	pass



func _process(delta):

	for r in range(8):
		for c in range(10):
			if soldier_grid[r][c].dead :
				
				pass
	


	#User control
	if userControled:	
		
		if Input.is_action_pressed("d"):
			position.x = position.x + 1;
			for soldier in get_children():
				soldier.randomMoveFromCeneter(0.8)
				pass

		if Input.is_action_pressed("a"):
			position.x = position.x - 1;
			for soldier in get_children():
				soldier.randomMoveFromCeneter(0.8)
				pass

		if Input.is_action_pressed("w"):
			position.y = position.y - 1;
			for soldier in get_children():
				soldier.randomMoveFromCeneter(0.8)
				pass

		if Input.is_action_pressed("s"):
			position.y = position.y + 1;
			for soldier in get_children():
				soldier.randomMoveFromCeneter(0.8)
				pass

		
	pass
