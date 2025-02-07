extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast = $RayCast2D

func _physics_process(delta):
	# Apply gravity if not on floor.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Play proper animation.
	if is_on_floor():
		if direction:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("jump")
	
	# Use move_and_slide (which updates is_on_floor() automatically)
	move_and_slide()
	
	if ray_cast.is_colliding():
		if ray_cast.get_collider().is_in_group("Danger"):
			Engine.time_scale = 0.5
			$CollisionShape2D.queue_free() if $CollisionShape2D else {}
			$Timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
