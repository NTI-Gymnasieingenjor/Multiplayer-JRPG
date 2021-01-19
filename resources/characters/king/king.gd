extends Position2D

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
	var active_character = get_tree().get_root().find_node("TurnQueue", true, false).get("active_character")
	
	var attackname = active_character.get("attack")
	
	db.open_db()
	db.query("SELECT * FROM attacks WHERE name='" + attackname + "';")
	
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
	yield(active_character.get_node("AnimatedSprite"), "animation_finished")

	rng.randomize()
	
	$DamageManager.show_value(rng.randi_range(mindamage, maxdamage))
