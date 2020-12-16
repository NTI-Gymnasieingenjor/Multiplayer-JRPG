extends "res://addons/gut/test.gd"

var battleui


func before_each():
	battleui = load("res://resources/ui/battle_ui/battle_ui.gd").new()


func test_attack_button_emit_attack_signal():
	watch_signals(battleui)
	battleui._on_AttackButton_button_down()
	assert_signal_emitted(battleui, "attack")


func test_attack_button_hide():
	battleui._on_AttackButton_button_down()
	if not battleui.is_visible():
		_pass("BattleUI is hidden properly after its been pressed.")
	else:
		_fail("BattleUI is still visible after its been pressed.")
