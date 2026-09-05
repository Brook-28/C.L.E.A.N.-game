extends CharacterBody2D

var facing = 1
var is_sliding
const SPEED = 700.0
const JUMP_VELOCITY = -400.0
const SLIDE_SPEED = 900
var direction = 0
var speed
var normalized_speed
const MAX_SPEED = 900


# GENERAL
func _process(delta: float) -> void:
	
	# variables for camera zoom
	speed = velocity.length()
	normalized_speed = speed / MAX_SPEED
	normalized_speed = clamp(normalized_speed, 0, 1)
	
	# variables for camera y position offset
	var mouse_pos = get_local_mouse_position().y
	var mouseY = clamp(mouse_pos, -50, 50)
	mouseY = float(mouseY)
	
	#if not is_sliding:
	update_visuals()
		
	# camera
	
	# camera x positoin logic
	if direction > 0:
		$Camera2D.offset.x = lerp($Camera2D.offset.x, 175.0, 5.0 * delta)
	elif direction < 0:
		$Camera2D.offset.x = lerp($Camera2D.offset.x, -175.0, 5.0 * delta)
	else:
		$Camera2D.offset.x = lerp($Camera2D.offset.x, 0.0, 2.0 * delta)
		
	# camera y position logic	
	if mouseY < 0:
		$Camera2D.offset.y = lerp($Camera2D.offset.y, mouseY, 5.0 * delta)
	elif mouseY > 0:
		$Camera2D.offset.y = lerp($Camera2D.offset.y, mouseY, 5.0 * delta)
	else:
		pass
	
	# camera speed dependant zoom logic
	var target_zoom = Vector2(1, 1).lerp(Vector2(0.8, 0.8), normalized_speed)
	$Camera2D.zoom = $Camera2D.zoom.lerp(target_zoom, 5 * delta)

# MOVEMENT
func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
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
	
	if direction and not is_sliding:
		if is_on_floor():
			velocity.x = move_toward(velocity.x,SPEED * direction, 1500 * delta)
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x,SPEED * direction, 600 *delta)
	elif not is_sliding:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta * 7125)
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, delta * 125)
	
	if is_sliding:
		velocity.x = move_toward(velocity.x,SPEED * direction,600 * delta)
		
	# Sliding
	if Input.is_action_just_pressed("slide") and is_on_floor():
		slide()
	
	if not Input.is_action_pressed("slide") and is_sliding:
		end_slide()
	
	
	move_and_slide()
	
	
func slide():
	if is_sliding:
		return
		
	# changing variables	
	is_sliding = true
	
	
	velocity.x = facing * SLIDE_SPEED
	$StandingCollision.disabled = true
	$LowerCollision.disabled = false
	
	if $LowerBody.flip_h == false and $UpperBody.flip_h == true:
		$UpperBody.flip_h = false
	elif $LowerBody.flip_h == true and $UpperBody.flip_h == false:
		$UpperBody.flip_h = true

	
	$UpperBody.position.y = 10.5
	$arms.position = Vector2(facing * -4, 13)
	$LowerBody.position.y = 10.5
	
	$LowerBody.play("sliding")
	
	
	
	
func end_slide():
	is_sliding = false
	$StandingCollision.disabled = false
	$LowerCollision.disabled = true
	$LowerBody.position.y = 0
	$arms.position = Vector2(0.5, 0)
	$UpperBody.position.y = 0
	$LowerBody.play("standing")
	
	
	
	
# VISUAL
func update_visuals():
	#upper body facing direction
	if get_global_mouse_position().x < global_position.x:
		$UpperBody.flip_h = true
		if is_sliding:
			$UpperBody.flip_h = facing < 0
			$UpperBody.position.x = 0
	else:
		$UpperBody.flip_h = false
	
	$LowerBody.flip_h = facing < 0
	
	# lower body pixel correction
	if $LowerBody.flip_h == false and $UpperBody.flip_h == true:
		$LowerBody.position.x = 1
	elif $LowerBody.flip_h == true and $UpperBody.flip_h == false:
		$LowerBody.position.x = -1
	else:
		$LowerBody.position.x = 0
	
	# lower body animation
	if velocity == Vector2.ZERO and not is_sliding:
		$LowerBody.play("standing")
	if velocity.x != 0 and not is_sliding and is_on_floor():
		$LowerBody.play("running")
	pass
	
	
	# sliding visuals
	
	if is_sliding:
		$UpperBody.rotation_degrees = -40 * facing
	else:
		$UpperBody.rotation_degrees = 0
