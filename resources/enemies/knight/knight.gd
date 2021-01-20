extends Position2D

# Loads Godot SQLite plugin.
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://attacks.db"

var is_enemy = true
var attack = "knightsword"

var rng = RandomNumberGenerator.new()

func _ready():
	$AnimatedSprite.play("Idle")
	
#	Instances Godot SQLite
	db = sqlite.new()
	db.path = db_name
	
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "take_damage")


func take_damage():
#	Defines current active character in turn queue and gets its attack.
	var active_character = get_tree().get_root().find_node("TurnQueue", true, false).get("active_character")
	var attackname = active_character.get("attack")
	
#	Retrieves mindamage and maxdamage of attack from database. 
	db.open_db()
	db.query("SELECT * FROM attacks WHERE name='" + attackname + "';")
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
	yield(active_character.get_node("AnimatedSprite"), "animation_finished")

	rng.randomize()
	$DamageManager.show_value(rng.randi_range(mindamage, maxdamage))


func play_turn():
	var dynamic_audio = get_tree().get_root().find_node("DynamicAudio", true, false)
	var player = AudioStreamPlayer.new()
	
	dynamic_audio.add_child(player)
	player.stream = load("res://resources/enemies/knight/" + attack + ".ogg")
	
	$AnimatedSprite.play("Attack")
	player.play()
	yield(get_node("AnimatedSprite"), "animation_finished")
	player.stop()
	$AnimatedSprite.play("Idle")
