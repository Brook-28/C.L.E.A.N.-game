extends CharacterBody2D

var facing = 1
var is_sliding
const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const SLIDE_SPEED = 650


# GENERAL
func _process(_delta: float) -> void:
	update_visuals()


# MOVEMENT
func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	# direction
	if direction != 0:
		facing = direction
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction and not is_sliding:
		if is_on_floor():
			velocity.x = move_toward(velocity.x,SPEED * direction,50)
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x,SPEED * direction,10)
	elif not is_sliding:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta * 3125)
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta * 125)
	
	# Sliding
	if Input.is_action_just_pressed("slide") and is_on_floor():
		slide()
	
	
	
	
	
	move_and_slide()
	
	
func slide():
	if is_sliding:
		return
		
	# changing basic variables	
	is_sliding = true
	$StandingCollision.disabled = true
	$LowerCollision.disabled = false
	$LowerBody.play("sliding")
	$UpperBody.play("sliding")
	
	# movement
	velocity.x = facing * SLIDE_SPEED
	
	await get_tree().create_timer(0.5).timeout
	
	# changing back basic variables	
	is_sliding = false
	$StandingCollision.disabled = false
	$LowerCollision.disabled = true
	$LowerBody.play("standing")
	$UpperBody.play("standing")
	
	


# VISUAL
func update_visuals():
	$LowerBody.flip_h = facing < 0
	$UpperBody.flip_h = facing < 0
	
	if velocity == Vector2.ZERO:
		$LowerBody.play("standing")
	if velocity.x != 0 and not is_sliding and is_on_floor():
		$LowerBody.play("running")
	pass
