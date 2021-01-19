extends Label


func _ready():
	pass


func show_value(value, duration):
	text = value
#	Fade out animation
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	queue_free()
