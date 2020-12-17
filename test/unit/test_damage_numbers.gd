extends "res://addons/gut/test.gd"

var king
var mainscene


func before_each():
	mainscene = load("res://main.tscn").instance()
	king = mainscene.get_node("King")


func test_show_damage_numbers():
	var damagemanager = king.get_node("DamageManager")
	king.handleattack()
	
	if damagemanager.has_node("DamageNumber"):
		if damagemanager.get_node("DamageNumber").is_visible():
			_pass("Damage numbers display after King collides with object")
		else:
			_fail("Damage numbers does not display after King collides with object")
	else:
		_fail("Damage numbers cannot be found after King collides with object")
