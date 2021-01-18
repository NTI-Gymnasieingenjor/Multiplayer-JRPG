extends Area2D

const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://attacks.db"

func _ready():
	db = sqlite.new()
	db.path = db_name
	
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "handleattack")


var rng = RandomNumberGenerator.new()
func handleattack():
	var attackname = "arrow"
	
	db.open_db()
	db.query("SELECT * FROM attacks WHERE name='" + attackname + "';")
	
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
	rng.randomize()

	# Currently only waits specific time, should wait until players attack animation is finished, and/or interact with it.
	yield(get_tree().create_timer(0.4), "timeout")

	$DamageManager.show_value(rng.randi_range(mindamage, maxdamage))
	
	db.query("UPDATE attacks SET maxdamage=maxdamage+10 WHERE name='" + attackname + "';")
