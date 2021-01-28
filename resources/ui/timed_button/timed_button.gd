extends TextureButton

signal state_set

var state : String = "miss"


func _ready():
#	Plays button fade in animation.
	$AnimatedSprite.play("Approach")
	
	yield($AnimatedSprite, "animation_finished")
	
	if $AnimatedSprite.animation == "Approach":
		state = "miss"
		emit_signal("state_set")


func _on_button_down():
	if $AnimatedSprite.animation == "Approach" and $AnimatedSprite.frame >= 5 and $AnimatedSprite.frame <= 7:
		state = "hit"
	else:
		state = "miss"
	
	emit_signal("state_set")


func hit():
	$AnimatedSprite.play("Hit")


func miss():
	$AnimatedSprite.play("Miss")
