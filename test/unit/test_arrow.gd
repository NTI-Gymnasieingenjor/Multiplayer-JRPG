extends "res://addons/gut/test.gd"

var arrow


func before_each():
	arrow = load("res://resources/arrow/arrow.gd").new()


func test_arrow_disappear_on_impact():
#	Checks if the Arrow is removed from the scene 1 frame after colliding with anything.
	arrow._on_Arrow_area_shape_entered(null, null, null, null)
	yield(get_tree(), "idle_frame")
	assert_freed(arrow, "Arrow")
