extends TextureButton

signal state_set

const ApproachCircle = preload("res://resources/ui/approach_circle/approach_circle.tscn")
var approach_circle

var state : String = "miss"


func _ready():
#	Fades in animation on button and approach circle
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
#	Instances and positions approach circle.
	approach_circle = ApproachCircle.instance()
	approach_circle.position = $AnimatedSprite.position
	add_child(approach_circle)
	
#	Plays default button animation.
	approach_circle.play("default")
	$AnimatedSprite.play("default")
	
#	Misses if approach animation times out.
	yield(approach_circle, "animation_finished")
	if $AnimatedSprite.animation == "default":
		state = "miss"
		emit_signal("state_set")
		approach_circle.queue_free()


func _on_button_down():
#	Hits if button is pressed on during specific frames of the approach animation.
	if approach_circle != null and $AnimatedSprite.animation == "default":
		if approach_circle.frame >= 42 and approach_circle.frame <= 48:
			state = "hit"
		else:
			state = "miss"
			
		emit_signal("state_set")
		
		approach_circle.queue_free()


func hit():
	$AnimatedSprite.play("Hit")


func miss():
	$AnimatedSprite.play("Miss")
