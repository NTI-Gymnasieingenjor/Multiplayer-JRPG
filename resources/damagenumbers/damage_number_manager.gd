extends Node2D

var Damage = preload("res://resources/damagenumbers/damage_numbers.tscn")

export var duration = 1


func _ready():
	pass


func show_value(value, height):
	var damage = Damage.instance()
	add_child(damage)
	
	damage.rect_position.y += -height - (damage.rect_size[1] / 2)
	
	damage.show_value(str(value), duration)
