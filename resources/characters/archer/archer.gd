extends Area2D

export (PackedScene) var Arrow


func _ready():
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "handleattack")


func handleattack():
	var arrow = Arrow.instance()
	add_child(arrow)
	arrow.position.y -= 4
	arrow.position.x += 15
	arrow.rotation_degrees = -10
