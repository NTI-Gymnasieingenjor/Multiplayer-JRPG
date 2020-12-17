extends MarginContainer

signal attack

func _ready():
	pass


func _on_AttackButton_button_down():
	self.hide()
	get_parent().get_node("TurnQueue").play_turn()
	emit_signal("attack")
