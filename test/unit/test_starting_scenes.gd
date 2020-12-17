extends "res://addons/gut/test.gd"


class TestStartingNodesPresent:
	extends "res://addons/gut/test.gd"
	
	var mainscene
	
	
	func custom_assert_present(node):
#		Checks if node is visible in the current scene.
		if mainscene.get_node(node).is_visible():
			_pass(node + " is present in starting scene.")
		else:
			_fail(node + " is not present in starting scene.")
	
	
	func before_each():
		mainscene = load("res://main.tscn").instance()
	
	
	func test_archer_present():
		custom_assert_present("Archer")
	
	
	func test_king_present():
		custom_assert_present("King")
	

	func test_battle_ui_present():
		custom_assert_present("BattleUI")
