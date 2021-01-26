extends Node2D

signal in_position
signal turn_finished

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


func _ready():
	original_position = position
	$AnimatedSprite.play("Idle")


func _physics_process(delta):
	if position.distance_to(target) > space and is_moving == true:
		position += velocity * speed * delta
	else:
		is_moving = false
		emit_signal("in_position")


func move(pos, spc):
	target = pos
	space = spc
	
	movement_angle = get_angle_to(pos)
	
	velocity.x = cos(movement_angle)
	velocity.y = sin(movement_angle)
	
	$AnimatedSprite.play("Running")
	is_moving = true


func play_turn():
	move(enemy.position, 50)

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
	
	self.scale.x = -self.scale.x
	
	move(original_position, 0)
	yield(self, "in_position")
	
	self.scale.x = -self.scale.x
	
	$AnimatedSprite.play("Idle")
	
	player.queue_free()
	
	enemy.take_damage()
	
	emit_signal("turn_finished")
