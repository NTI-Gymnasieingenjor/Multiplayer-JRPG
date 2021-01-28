extends Node2D

signal button_pressed

const TimedButton = preload("res://resources/ui/timed_button/timed_button.tscn")
var button
var buttonsprite

onready var rootnode = get_tree().root.get_node("Node2D")
onready var active_character = rootnode.get_node("TurnQueue").active_character


func spawn_timed_button():
#	Creates new TimedButton instance and sets its position accordingly.
	button = TimedButton.instance()
	
#	Positions button on top of active character.
	button.rect_position = active_character.enemy.position
	
#	Temporary hardcoded positioning of button.
	button.rect_position -= Vector2(7, 7)
	button.rect_position.x -= 20
	
	add_child(button)
	
	buttonsprite = button.get_node("AnimatedSprite")
	
#	Plays button fade in animation.
	buttonsprite.play("Approach")
	yield(button, "button_down")
	
	if buttonsprite.frame > 4:
		buttonsprite.play("Hit")
		active_character.timing = "hit"
	else:
		buttonsprite.play("Miss")
		active_character.timing = "miss"
		
	emit_signal("button_pressed")
	
	yield(buttonsprite, "animation_finished")
	button.queue_free()
