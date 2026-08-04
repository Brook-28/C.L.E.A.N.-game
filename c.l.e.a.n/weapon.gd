class_name Weapon
extends Node2D

enum WeaponType { ARMS, REVOLVER, KATANA, RPG, UZI, SHOTGUN }

var current_weapon_type = WeaponType.ARMS


func _process(_delta: float) -> void:
	pass

func fire():
	pass
