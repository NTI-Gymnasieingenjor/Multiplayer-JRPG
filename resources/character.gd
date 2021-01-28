extends Node2D

signal in_position
signal turn_finished

onready var rootnode = get_tree().root.get_node("Node2D")
onready var timinguimanager = rootnode.get_node("TimingUIManager")

var rng = RandomNumberGenerator.new()

var attack : String
var is_enemy : bool
var enemy

var target = Vector2()
var velocity = Vector2()
var movement_angle = Vector2()
var original_position = Vector2()

var is_moving : bool
export var speed : int = 200

var space : int

var timing : String = "hit"


func _ready():
	original_position = position
	$AnimatedSprite.play("Idle")


func _physics_process(delta):
	if position.distance_to(target) > space and is_moving == true:
		position += velocity * speed * delta
	else:
		is_moving = false
		emit_signal("in_position")


func move(pos : Vector2, spc : int):
	target = pos
	space = spc
	
	movement_angle = get_angle_to(pos)
	
	velocity.x = cos(movement_angle)
	velocity.y = sin(movement_angle)
	
	$AnimatedSprite.play("Running")
	is_moving = true


func timed_button():
	pass


func play_turn():
#	Creates new AudioStreamPlayer instance.
	var dynamic_audio = rootnode.get_node("DynamicAudio")
	var player = AudioStreamPlayer.new()
	dynamic_audio.add_child(player)
	
#	Loads attack sound effect.
	player.stream = load(self.get_filename().replace(self.get_name().to_lower() + ".tscn", attack + ".ogg"))
	
	
#	Draws character on top of others during turn.
	self.z_index += 1
	
#	Moves up to enemy.
	move(enemy.position, 50)
	yield(self, "in_position")
	
#	Spawns a timed attack button and waits for it to be pressed.
	if not is_enemy:
		$AnimatedSprite.play("Idle")
		timinguimanager.spawn_timed_button()
		yield(timinguimanager, "button_finished")
	
	if timing == "hit":
	#	Plays attack animation and sound.
		$AnimatedSprite.play("Attack")
		player.play()
		yield(get_node("AnimatedSprite"), "animation_finished")
		player.stop()
		
	#	Deals damage to enemy.
		enemy.take_damage()
	
#	Flips sprite and returns to original position.
	$AnimatedSprite.set_flip_h(true)
	move(original_position, 0)
	yield(self, "in_position")
	
#	Flips sprite back and plays idle animation.
	$AnimatedSprite.set_flip_h(false)
	$AnimatedSprite.play("Idle")
	
#	Returns z index to original value.
	self.z_index -= 1
	
	
#	Removes AudioStreamPlayer instance from memory.
	player.queue_free()
	
	emit_signal("turn_finished")
