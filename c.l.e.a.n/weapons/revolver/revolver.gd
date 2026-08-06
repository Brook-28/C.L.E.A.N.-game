extends Weapon


@onready var sprite = $AnimatedSprite2D


func _process(_delta: float) -> void:
	super._process(_delta)
	weapon_direction()
	

func weapon_direction():
	
	#flip logic
	if mouse_pos.x < global_position.x:
		sprite.flip_h = true
		sprite.position.x = -6
		angle = 180.0 - angle
		if angle > 180.0:
			angle -= 360.0
		
	else:
		sprite.flip_h = false
		sprite.position.x = 6
			
	
	# animation selector
	if angle < -78.75:
		sprite.play("up_up")
	elif angle < - 56.25:
		sprite.play("up_high")
	elif angle < -33.75:
		sprite.play("up_middle")
	elif angle < -11.25:
		sprite.play("up_low")
	elif angle < 11.25:
		sprite.play("straight")
	elif angle < 33.75:
		sprite.play("down_high")
	elif angle < 56.25:
		sprite.play("down_low")
	else:
		sprite.play("down_down")
