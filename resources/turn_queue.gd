extends Node2D

class_name TurnQueue

var active_character

func _ready():
	active_character = get_child(0)
	battle_loop()

func battle_loop():
	var battleui = get_tree().get_root().find_node("BattleUI", true, false)
	
	while true:
		match active_character.get("is_enemy"):
			true:
				pass
			false:
				battleui.show()
				yield(battleui, "attack")
		
		active_character.play_turn()
		yield(active_character.get_node("AnimatedSprite"), "animation_finished")

		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		active_character = get_child(new_index)
