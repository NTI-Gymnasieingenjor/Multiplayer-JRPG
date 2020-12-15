extends Area2D


func _ready():
	pass


var rng = RandomNumberGenerator.new()
func _on_King_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	rng.randomize()
	$DamageManager.show_value(rng.randi_range(10, 100), ($Sprite.texture.get_height() / 2))
