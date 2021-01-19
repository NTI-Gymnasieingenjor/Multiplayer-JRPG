extends Position2D

var attack = "archermelee"


func _ready():
	$AnimatedSprite.play("Idle")


func play_turn():
	$AnimatedSprite.play("Attack")
	yield(get_node("AnimatedSprite"), "animation_finished")
	$AnimatedSprite.play("Idle")
