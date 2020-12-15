extends Area2D

export var speed = 400


func _ready():
	pass


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Arrow_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	queue_free()
