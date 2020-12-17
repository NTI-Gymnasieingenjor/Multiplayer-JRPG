extends Node2D

var Damage = preload("res://resources/damagenumbers/damage_numbers.tscn")

export var duration = 1


func _ready():
	pass


func show_value(value):
	var damage = Damage.instance()
	add_child(damage)
	
#	Positions damage number above the sprite (SPRITE NODE MUST BE NAMED "Sprite"!)
	damage.rect_position.y -= ((get_parent().get_node("Sprite").texture.get_height() / 2) + (damage.rect_size[1] / 2))
	
	damage.show_value(str(value), duration)
