extends Node2D

signal button_finished

const TimedButton = preload("res://resources/ui/timed_button/timed_button.tscn")
var button
var buttonsprite

onready var rootnode = get_tree().root.get_node("Node2D")
var active_character


func spawn_timed_button():
	active_character = rootnode.get_node("TurnQueue").active_character
	
#	Creates new TimedButton instance.
	button = TimedButton.instance()
	buttonsprite = button.get_node("AnimatedSprite")
	
#	Positions button on top of the enemy of the current active characters.
	button.rect_position = active_character.enemy.position
	
#	TEMPORARY HARDCODED POSITIONING OF BUTTON.
	button.rect_position -= Vector2(7, 7)
	button.rect_position.x -= 18
	
	add_child(button)
	
#	Waits for button to return if its been missed or hit.
	yield(button, "state_set")
	
	active_character.timing = button.state
	
	if button.state == "hit":
		button.hit()
	else:
		button.miss()
	
	emit_signal("button_finished")
	
	yield(buttonsprite, "animation_finished")
	button.queue_free()
