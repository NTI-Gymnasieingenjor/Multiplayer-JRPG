extends Node2D

class_name TurnQueue

var active_character

func _ready():
	active_character = get_child(0)
	
func play_turn():
	active_character.play_turn()
	yield(active_character.get_node("AnimatedSprite"), "animation_finished")
	
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	
	get_tree().get_root().find_node("BattleUI", true, false).show()
