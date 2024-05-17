extends State
# . . . STATE ATTACK . . .

var defender:Army;
var attackTime = 0

func setData(data):
	defender = data

func readyMode():
	attackTime = 0;
	setProcess()

func processMode(delta):
	attackTime += delta
	
	if(attackTime > 1):
		get_parent().takeDamage(1)
		setState($"../stateDone")
		
		if get_parent().health <= 0:
			setState($"../stateXDead")
			
