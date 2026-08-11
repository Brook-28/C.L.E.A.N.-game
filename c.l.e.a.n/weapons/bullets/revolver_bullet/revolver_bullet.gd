extends Area2D

const SPEED = 4000
var direction: Vector2
const RANGE = 20
var travelled = 0
var collided = false

func _physics_process(delta: float) -> void:
	
	if direction.length() > 0:
		rotation = direction.angle()

	
	if travelled < RANGE:
		position += direction.normalized() * SPEED * delta
		travelled += 1
		
	if travelled == RANGE or collided:
		queue_free()
#func on hit():
# collided = true
