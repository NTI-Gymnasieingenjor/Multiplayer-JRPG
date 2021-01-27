extends "res://resources/character.gd"

signal button_pressed

onready var timinguimanager = rootnode.get_node("TimingUIManager")


func _ready():
	is_enemy = false


func take_damage():
	pass


func timed_button():
	timinguimanager.spawn_timed_button()
	
	var button = timinguimanager.get_node("TimedButton")
	var buttonsprite = button.get_node("AnimatedSprite")
	
#	Plays button fade in animation.
	buttonsprite.play("Approach")
	yield(button, "button_down")
	
	if buttonsprite.frame > 4:
		buttonsprite.play("Hit")
		timing = "hit"
	else:
		buttonsprite.play("Miss")
		timing = "miss"
		
	emit_signal("button_pressed")
	
	yield(buttonsprite, "animation_finished")
	button.queue_free()
