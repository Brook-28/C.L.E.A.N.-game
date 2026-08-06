extends Node2D


enum WeaponType { ARMS = 1, REVOLVER = 2, KATANA = 3, RPG = 4, UZI = 5, SHOTGUN = 6}

var current_weapon = WeaponType.ARMS


var weapon_scenes = {
WeaponType.REVOLVER:preload("res://weapons/revolver/revolver.tscn"),
WeaponType.ARMS:preload("res://weapons/arms/arms.tscn"),
}


func switch_weapon(new_weapon: WeaponType) -> void:
	current_weapon = new_weapon
	
	#delete old weapon
	for child in get_children():
		child.queue_free()
		
	#spawn the new weapon
	var new_scene = weapon_scenes[new_weapon]
	var new_instance = new_scene.instantiate()
	add_child(new_instance)

func _ready() -> void:
	switch_weapon(WeaponType.ARMS)
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("fists_select") and current_weapon != WeaponType.ARMS:
		switch_weapon(WeaponType.ARMS)
		print(1)
		
	if Input.is_action_just_pressed("revolver_select") and current_weapon != WeaponType.REVOLVER:
		switch_weapon(WeaponType.REVOLVER)
		print(2)
