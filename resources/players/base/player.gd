extends "res://resources/character.gd"

signal button_pressed

const TimedButton = preload("res://resources/ui/timed_button/timed_button.tscn")
var button


func _ready():
	is_enemy = false


func take_damage():
	pass


func timed_button():
	$AnimatedSprite.play("Idle")
	
#	Creates new TimedButton instance and sets its position accordingly.
	button = TimedButton.instance()
	button.rect_position.x += 25
	var buttonsprite = button.get_node("AnimatedSprite")
	self.add_child(button)
	
#	Plays button fade in animation.
	buttonsprite.play("Approach")
	yield(button, "button_down")
	
	if buttonsprite.frame == 1:
		buttonsprite.play("Hit")
		timing = "hit"
	else:
		buttonsprite.play("Miss")
		timing = "miss"
		
	yield(buttonsprite, "animation_finished")
	
	button.queue_free()
	emit_signal("button_pressed")
