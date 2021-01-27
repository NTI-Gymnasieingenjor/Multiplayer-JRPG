extends "res://resources/enemies/base/enemy.gd"


func _ready():
	attack = "knightsword"
#	TEMPORARILY HARDCODED
	enemy = get_parent().get_node("Archer")
