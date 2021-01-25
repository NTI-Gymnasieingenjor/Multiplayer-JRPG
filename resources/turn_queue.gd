extends Node2D

class_name TurnQueue

var active_character


func _ready():
	active_character = get_child(0)
	battle_loop()


func battle_loop():
	var battleui = get_tree().get_root().find_node("BattleUI", true, false)
	
#	Shows BattleUI if active character is a player character.
	while true:
		match active_character.get("is_enemy"):
			true:
				pass
			false:
				battleui.show()
				yield(battleui, "attack")
		
		active_character.play_turn()
		yield(active_character, "turn_finished")
		
		next_turn()


func next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)


func return_next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	return get_child(new_index)
