extends Area2D

export (PackedScene) var Arrow


func _ready():
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "handleattack")


func handleattack():
#	Runs when BattleUI emits the "attack" signal.
	play_turn()


func play_turn():
	var arrow = Arrow.instance()
	add_child(arrow)
	arrow.position.y -= 4
	arrow.position.x += 15
	arrow.rotation_degrees = -10
