extends MarginContainer

signal attack


func _ready():
	pass


func _on_AttackButton_button_down():
	self.hide()
	emit_signal("attack")
