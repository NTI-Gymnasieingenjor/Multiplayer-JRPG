extends Node2D

signal in_position
signal turn_finished

var attack : String
var is_enemy : bool
var enemy

var target = Vector2()
var velocity = Vector2()
var movement_angle = Vector2()

var move : bool
export var speed : int = 200


func _ready():
	$AnimatedSprite.play("Idle")


func _physics_process(delta):
	if position.distance_to(target) > 50 and move == true:
		position += velocity * speed * delta
	else:
		move = false
		emit_signal("in_position")


func move_to_enemy():
	target = enemy.position
	movement_angle = get_angle_to(target)
	
	velocity.x = cos(movement_angle)
	velocity.y = sin(movement_angle)
	
	$AnimatedSprite.play("Running")
	move = true


func play_turn():
	move_to_enemy()

	yield(self, "in_position")
	
#	Creates new AudioStreamPlayer instance.
	var dynamic_audio = get_tree().get_root().find_node("DynamicAudio", true, false)
	var player = AudioStreamPlayer.new()
	dynamic_audio.add_child(player)
	
#	Loads attack sound effect.
	player.stream = load(self.get_filename().replace(self.get_name().to_lower() + ".tscn", attack + ".ogg"))
	
#	Plays attack animation and sound.
	$AnimatedSprite.play("Attack")
	player.play()
	
	yield(get_node("AnimatedSprite"), "animation_finished")
	
#	Stops sound effect and returns to idle animation.
	player.stop()
	$AnimatedSprite.play("Idle")
	
	player.queue_free()
	
	enemy.take_damage()
	
	emit_signal("turn_finished")
