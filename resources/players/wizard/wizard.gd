extends "res://resources/players/base/player.gd"


func _ready():
	attack = "flamethrower"
#	TEMPORARILY HARDCODED
	enemy = get_parent().get_node("Knight")
