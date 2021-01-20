extends Position2D

var is_enemy = false
var attack = "archermelee"


func _ready():
	$AnimatedSprite.play("Idle")


func play_turn():
	var dynamic_audio = get_tree().get_root().find_node("DynamicAudio", true, false)
	var player = AudioStreamPlayer.new()
	
	dynamic_audio.add_child(player)
	player.stream = load("res://resources/characters/archer/" + attack + ".ogg")
	
	$AnimatedSprite.play("Attack")
	player.play()
	yield(get_node("AnimatedSprite"), "animation_finished")
	player.stop()
	$AnimatedSprite.play("Idle")
