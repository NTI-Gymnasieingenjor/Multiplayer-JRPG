extends Node2D

const TimedButton = preload("res://resources/ui/timed_button/timed_button.tscn")
var button

onready var rootnode = get_tree().root.get_node("Node2D")

func spawn_timed_button():
#	Creates new TimedButton instance and sets its position accordingly.
	button = TimedButton.instance()
	
#	Positions button on top of active character.
	button.rect_position = rootnode.get_node("TurnQueue").active_character.enemy.position
	
#	Temporary hardcoded positioning of button.
	button.rect_position -= Vector2(7, 7)
	button.rect_position.x -= 20
	
	add_child(button)
