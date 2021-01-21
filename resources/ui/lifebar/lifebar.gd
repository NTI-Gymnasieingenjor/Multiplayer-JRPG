extends TextureProgress

# Loads Godot SQLite plugin.
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://data.db"


func _ready():
#	Instances Godot SQLite
	db = sqlite.new()
	db.path = db_name
	
#	Retrieves hp of parent from database. 
	db.open_db()
	db.query("SELECT * FROM enemies WHERE name='" + get_parent().get_name().to_lower() + "';")
	max_value = db.query_result[0]["hp"]
	

func _physics_process(delta):
	value = get_parent().hp
	
