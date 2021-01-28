extends "res://resources/enemies/base/enemy.gd"


func _ready():
	attack = "knightsword"
	
#	TEMPORARY HARDCODED CHOICE OF ENEMY TO ATTACK EACH TURN.
	while true:
		rng.randomize()
		var character = rng.randi_range(0, 1)
		if character == 0:
			enemy = get_parent().get_node("Wizard")
		else:
			enemy = get_parent().get_node("Archer")
		
#	TEMPORARY HARDCODED, DRAWS KNIGHT BEHIND ARCHER IF WIZARD IS ATTACKED.
		if enemy.get_name() == "Wizard":
			get_parent().get_node("Archer").z_index += 2
		
		yield(self, "turn_finished")
		
		if enemy.get_name() == "Wizard":
			get_parent().get_node("Archer").z_index -= 2
