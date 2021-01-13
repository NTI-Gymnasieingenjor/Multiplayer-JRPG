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
	db.open_db()
	db.query("select * from attacks;")
	
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
	rng.randomize()
	$DamageManager.show_value(rng.randi_range(mindamage, maxdamage))
