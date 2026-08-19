extends Area2D

const SPEED = 3000
var direction: Vector2
const RANGE = 1000
var travelled: Vector2
var collided = false

func _physics_process(delta: float) -> void:
	
	if direction.length() > 0:
		rotation = direction.angle()

	
	if travelled.length() < RANGE:
		position += direction.normalized() * SPEED * delta
		travelled += direction.normalized() * SPEED * delta
		
		
	if travelled.length() >= RANGE or collided:
		queue_free()
#func on hit():
# collided = true
