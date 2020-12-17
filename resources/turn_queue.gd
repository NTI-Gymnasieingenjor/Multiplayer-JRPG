extends Node2D

class_name TurnQueue

var active_character

func _ready():
	active_character = get_child(0)
	
func play_turn():
	active_character.play_turn()
#	Currently only yields for specific time, should yield until active characters turn is completed.
	yield(get_tree().create_timer(0.5), "timeout")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	get_parent().get_node("BattleUI").show()
