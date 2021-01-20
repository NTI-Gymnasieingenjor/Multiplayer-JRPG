extends Node2D

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://resources/audio/boss_battle_#2_metal_opening.ogg")
	player.set_volume_db(-5.0)
	player.play()
	
	yield(player, "finished")
	
	player.stream = load("res://resources/audio/boss_battle_#2_metal_loop.ogg")
	player.play()
