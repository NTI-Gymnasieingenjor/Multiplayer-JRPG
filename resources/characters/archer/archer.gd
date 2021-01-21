extends Position2D

var is_enemy = false
var attack = "archermelee"


func _ready():
	$AnimatedSprite.play("Idle")


func play_turn():
#	Creates new AudioStreamPlayer instance.
	var dynamic_audio = get_tree().get_root().find_node("DynamicAudio", true, false)
	var player = AudioStreamPlayer.new()
	dynamic_audio.add_child(player)
	
#	Loads attack sound effect.
	player.stream = load("res://resources/characters/archer/" + attack + ".ogg")
	
#	Plays attack animation and sound.
	$AnimatedSprite.play("Attack")
	player.play()
	
	yield(get_node("AnimatedSprite"), "animation_finished")
	
#	Stops sound effect and returns to idle animation.
	player.stop()
	$AnimatedSprite.play("Idle")
	
	player.queue_free()
