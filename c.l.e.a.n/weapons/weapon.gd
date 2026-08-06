class_name Weapon
extends Node2D

var mouse_pos: Vector2
var angle

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	angle = rad_to_deg(global_position.direction_to(mouse_pos).angle())

func fire():
	pass
