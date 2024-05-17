extends State
# - DEFEND STATE

var attacker:Army;
var defendTime = 0

func setData(data):
	attacker = data

func readyMode():
	defendTime = 0;
	setProcess()

func processMode(delta):
	defendTime += delta
	
	if(defendTime > 1):
		get_parent().takeDamage(1)
		setState($"../stateDone")
		
		if get_parent().health <= 0:
			setState($"../stateXDead")
			
