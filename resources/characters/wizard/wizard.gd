extends Position2D

func play_turn():
	$AnimatedSprite.play("Attack")
	yield(get_node("AnimatedSprite"), "animation_finished")
	$AnimatedSprite.play("Idle")
