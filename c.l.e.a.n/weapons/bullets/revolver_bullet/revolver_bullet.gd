extends Area2D

const SPEED = 100
var direction: Vector2
const RANGE = 5000
var travelled = 0
var collided = false

func _physics_process(delta: float) -> void:
	if travelled < RANGE:
		position += direction.normalized() * SPEED * delta
		travelled += 1
		
	if travelled > RANGE or collided:
		queue_free()
#func on hit():
# collided = true
