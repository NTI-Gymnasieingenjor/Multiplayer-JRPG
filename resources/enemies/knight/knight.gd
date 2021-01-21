extends Position2D

# Loads Godot SQLite plugin.
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://data.db"

var is_enemy = true
var attack = "knightsword"
var hp

var rng = RandomNumberGenerator.new()


func _ready():
	$AnimatedSprite.play("Idle")
	
#	Instances Godot SQLite
	db = sqlite.new()
	db.path = db_name
	
#	Retrieves hp from database. 
	db.open_db()
	db.query("SELECT * FROM enemies WHERE name='" + self.get_name().to_lower() + "';")
	hp = db.query_result[0]["hp"]
	
#	Connects BattleUI's attack signal to a function in this script.
	var BattleUI = get_tree().get_root().find_node("BattleUI", true, false)
	BattleUI.connect("attack", self, "take_damage")


func take_damage():
#	Defines current active character in turn queue and gets its attack.
	var active_character = get_tree().root.get_node("Node2D").get_node("TurnQueue").get("active_character")
	var attackname = active_character.get("attack")
	
#	Retrieves mindamage and maxdamage of attack from database. 
	db.open_db()
	db.query("SELECT * FROM attacks WHERE name='" + attackname + "';")
	var mindamage = db.query_result[0]["mindamage"]
	var maxdamage = db.query_result[0]["maxdamage"]
	
	yield(active_character.get_node("AnimatedSprite"), "animation_finished")
	
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


func play_turn():
#	Creates new AudioStreamPlayer instance.
	var dynamic_audio = get_tree().get_root().find_node("DynamicAudio", true, false)
	var player = AudioStreamPlayer.new()
	dynamic_audio.add_child(player)
	
#	Loads attack sound effect.
	player.stream = load("res://resources/enemies/knight/" + attack + ".ogg")
	
#	Plays attack animation and sound.
	$AnimatedSprite.play("Attack")
	player.play()
	
	yield(get_node("AnimatedSprite"), "animation_finished")
	
#	Stops sound effect and returns to idle animation.
	player.stop()
	$AnimatedSprite.play("Idle")
	
	player.queue_free()
