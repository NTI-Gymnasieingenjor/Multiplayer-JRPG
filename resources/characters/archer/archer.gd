extends Position2D

func _ready():
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "handleattack")


func handleattack():
#	Runs when BattleUI emits the "attack" signal.
	play_turn()


func play_turn():
	$AnimatedSprite.play("Attack")
