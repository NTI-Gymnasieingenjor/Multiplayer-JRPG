extends "res://resources/character.gd"

signal successful_timing

const TimedButton = preload("res://resources/ui/timedbutton/timedbutton.tscn")
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
	self.add_child(button)
	
	yield(button, "button_down")
	
	button.queue_free()
	emit_signal("successful_timing")
