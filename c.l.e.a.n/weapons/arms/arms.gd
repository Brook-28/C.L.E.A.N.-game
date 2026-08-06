extends Weapon

@onready var sprite = $AnimatedSprite2D


func _process(_delta: float) -> void:
	super._process(_delta)
	weapon_direction()
	

func weapon_direction():
	
	#flip logic
	if mouse_pos.x < global_position.x:
		sprite.flip_h = true
		
		angle = 180.0 - angle
		if angle > 180.0:
			angle -= 360.0
		
	else:
		sprite.flip_h = false
		
			
	
