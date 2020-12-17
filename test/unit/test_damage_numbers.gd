extends "res://addons/gut/test.gd"

var damagenumber
var king


func before_each():
	damagenumber = load("res://resources/damagenumbers/damage_numbers.tscn").instance()
	king = load("res://resources/characters/king/king.tscn").instance()


func test_show_damage_numbers():
	king._on_King_area_shape_entered(null, null, null, null)
	if damagenumber.is_visible():
		_pass("Damage numbers display after King collides with object")
	else:
		_fail("Damage numbers does not display after King collides with object")
