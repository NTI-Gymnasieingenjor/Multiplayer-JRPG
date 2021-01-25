extends "res://resources/character.gd"

# Loads Godot SQLite plugin.
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://data.db"

var hp : int

var rng = RandomNumberGenerator.new()


func _ready():
	is_enemy = true
	
#	Instances Godot SQLite
	db = sqlite.new()
	db.path = db_name
	
#	Retrieves hp from database. 
	db.open_db()
	db.query("SELECT * FROM enemies WHERE name='" + self.get_name().to_lower() + "';")
	hp = db.query_result[0]["hp"]


func take_damage():
#	Defines current active character in turn queue and gets its attack.
	var active_character = get_tree().root.get_node("Node2D").get_node("TurnQueue").get("active_character")
	var attackname = active_character.get("attack")
	
#	Retrieves mindamage and maxdamage of attack from database. 
	db.open_db()
	db.query("SELECT * FROM attacks WHERE name='" + attackname + "';")
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
#	Takes damage and displays damage dealt above sprite.
	rng.randomize()
	var damage = rng.randi_range(mindamage, maxdamage)
	hp -= damage
	$DamageManager.show_value(damage)
	
	if hp <= 0:
		die()


func die():
#	If this characters turn is coming up, skip that turn.
	if self == get_parent().return_next_turn():
		get_parent().next_turn()
	queue_free()
	
	win()


func win():
#	Remove BattleUI and show victory screen.
	get_tree().root.get_node("Node2D").get_node("BattleUI").queue_free()
	get_tree().root.get_node("Node2D").get_node("WinState").show()

