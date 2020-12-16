extends "res://addons/gut/test.gd"

var archer


func before_each():
	archer = load("res://resources/characters/archer/archer.tscn").instance()


func test_shoot_arrow():
	archer.handleattack()
	if archer.get_node("Arrow").is_visible():
		_pass("Arrow is visible after archer handles the attack signal.")
	else:
		_fail("Arrow is not visible after archer handles the attack signal.")
