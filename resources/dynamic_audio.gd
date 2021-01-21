extends Node2D


func _ready():
	boss_music()

func boss_music():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	
	player.set_volume_db(-5.0)
	
	player.stream = load("res://resources/bgm/boss_battle/boss_battle_#2_metal_opening.ogg")
	player.play()
	
	yield(player, "finished")
	
	player.stream = load("res://resources/bgm/boss_battle/boss_battle_#2_metal_loop.ogg")
	player.play()
