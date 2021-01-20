extends Node2D

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://resources/audio/boss_battle_#2_metal_loop.ogg")
	player.play()
