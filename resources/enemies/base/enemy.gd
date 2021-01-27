extends "res://resources/character.gd"

# Loads Godot SQLite plugin.
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://data.db"

const DamageManager = preload("res://resources/damagenumbers/damage_manager.tscn")
var dmgmanager

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
#	Creates new DamageManager instance.
	dmgmanager = DamageManager.instance()
	self.add_child(dmgmanager)
	
#	Defines current active character in turn queue and gets its attack.
	var active_character = rootnode.get_node("TurnQueue").get("active_character")
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
	dmgmanager.show_value(damage)
	
	if hp <= 0:
		die()
	
#	Yields until damage numbers fade out completely.
	yield(dmgmanager.get_node("DamageNumber").get_node("Tween"), "tween_all_completed")
	
	dmgmanager.queue_free()


func die():
	queue_free()
	win()


func win():
#	Draws characters below the victory screen.
	get_parent().z_index -= 5
	
	get_parent().victory = true
	
#	Remove BattleUI and show victory screen.
	rootnode.get_node("BattleUI").queue_free()
	rootnode.get_node("WinState").show()

