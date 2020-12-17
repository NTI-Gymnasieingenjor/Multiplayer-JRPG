extends Area2D


func _ready():
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "handleattack")


var rng = RandomNumberGenerator.new()
func handleattack():
	rng.randomize()
	# Currently only waits specific time, should wait until players attack animation is finished, and/or interact with it.
	yield(get_tree().create_timer(0.4), "timeout")
	$DamageManager.show_value(rng.randi_range(10, 100))
