extends CharacterBody2D


const ACCELERATION = 6000
const MAX_SPEED = 20000
const MAX_FALL_SPEED = 300
const JUMP_HEIGHT = 50000
const MIN_JUMP_HEIGHT = 24000
const MAX_COYOTE_TIME = 6
const MAX_COYOTE_WALL_TIME = 6
const JUMP_BUFFER_TIME = 10
const WALL_JUMP_AMOUNT = 24000
const WALL_JUMP_TIME = 10
const WALL_SLIDE_FACTOR = 0.8
const WALL_HORIZONTAL_TIME = 30
const GRAVITY = 3000
const WEAK_GRAVITY = 1000
const DASH_SPEED = 20000
const CLIMB_SPEED = 20000

@onready var animated_sprite_2d = $AnimatedSprite2D
#@onready var ray_cast = $RayCast2D

var input_axis = Vector2()

var coyoteTimer = 0
var coyoteWallTimer = 0
var jumpBufferTimer = 0
var wallJumpTimer = 0
var wallHorizontalTimer = 0
var dashTime = 0

var spriteColor = "red"
var canJump = false
var friction = false
var wall_sliding = false
var trail = false
var isDashing = false
var hasDashed = false
var isGrabbing = false

var prev_checkpoint_position = Vector2(0, 0)

var followers = []

enum FruitColor {RED, GREEN, BLUE}
var current_color

const MIN_X_DISTANCE = 40
const MIN_Y_DISTANCE = 5
const FOLLOW_SPEED = 2.5

func _ready() -> void:
	prev_checkpoint_position = position

func _physics_process(delta):
	if !isDashing:
		if velocity.y < MAX_FALL_SPEED:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += WEAK_GRAVITY * delta
	
	friction = false
	
	getInputAxis()
	#dash(delta)
	
	wallSlide(delta)

	if wallJumpTimer > WALL_JUMP_TIME:
		wallJumpTimer = WALL_JUMP_AMOUNT
		if !isDashing && !isGrabbing:
			horizontalMovement(delta)
	else:
		wallJumpTimer += 1
	
	if !canJump:
		if !wall_sliding:
			if velocity.y >= 0:
				$AnimatedSprite2D.play("fall")
			elif velocity.y < 0:
				$AnimatedSprite2D.play("jump")
				
	if is_on_floor():
		canJump = true
		coyoteTimer = 0
	else:
		coyoteTimer += 1
		if coyoteTimer > MAX_COYOTE_TIME:
			canJump = false
			coyoteTimer = 0
		friction = true
	
	jumpBuffer(delta)

	if Input.is_action_just_pressed("jump"):
		if canJump:
			jump(delta)
			frictionOnAir()
		else:
			if $WallCast.is_colliding() and $WallCast.get_collider().is_in_group("Climbable"):
				wallJump(delta)
			frictionOnAir()
			jumpBufferTimer = JUMP_BUFFER_TIME #amount of frame

	setJumpHeight(delta)
	jumpBuffer(delta)
		
	move_and_slide()
	if sign(velocity.x)<0: $AnimatedSprite2D.flip_h = true
	elif sign(velocity.x)>0: $AnimatedSprite2D.flip_h = false
	
	update_follows(delta)

func jump(delta):
	velocity.y = -JUMP_HEIGHT * delta

func wallJump(delta):
	wallJumpTimer = 0
	velocity.x = -WALL_JUMP_AMOUNT * $WallCast.scale.x * delta
	velocity.y = -JUMP_HEIGHT * delta
	$WallCast.scale.x = -$WallCast.scale.x

func wallSlide(delta):
	if !canJump:
		if $WallCast.is_colliding() and $WallCast.get_collider().is_in_group("Climbable"):
			coyoteWallTimer = 0
			wall_sliding = true
			if Input.is_action_pressed("grab"):
				isGrabbing = true
				if input_axis.y != 0:
					velocity.y = input_axis.y * CLIMB_SPEED * delta
					$AnimatedSprite2D.play("climbing")
				else:
					velocity.y = 0
					$AnimatedSprite2D.play("sliding")
			else:
				isGrabbing = false
				velocity.y = velocity.y * WALL_SLIDE_FACTOR
				$AnimatedSprite2D.play("sliding")
		else:
			wall_sliding = false
			isGrabbing = false
			coyoteWallTimer += 1
			if coyoteWallTimer < MAX_COYOTE_WALL_TIME:
				if input_axis.y != 0:
					velocity.y = input_axis.y * CLIMB_SPEED * delta
					$AnimatedSprite2D.play("climbing")
	

func frictionOnAir():
	if friction:
		velocity.x = lerp(velocity.x, 0.0, 0.01)

func jumpBuffer(delta):
	if jumpBufferTimer > 0:
		if is_on_floor():
			jump(delta)
		jumpBufferTimer -= 1

func setJumpHeight(delta):
	if Input.is_action_just_released("move_up"):
		if velocity.y < -MIN_JUMP_HEIGHT * delta:
			velocity.y = -MIN_JUMP_HEIGHT * delta

func horizontalMovement(delta):
	if Input.is_action_pressed("move_right"):
		if $WallCast.is_colliding():
			#await (get_tree().create_timer(0.1),"timeout")
			velocity.x = min(velocity.x + ACCELERATION * delta, MAX_SPEED * delta)
			$WallCast.scale.x = 1
			if canJump:
				$AnimatedSprite2D.play("run")
		else:
			velocity.x = min(velocity.x + ACCELERATION * delta, MAX_SPEED * delta)
			$WallCast.scale.x = 1
			if canJump:
				$AnimatedSprite2D.play("run")

	elif Input.is_action_pressed("move_left"):
		if $WallCast.is_colliding():
			#await (get_tree().create_timer(0.1),"timeout")
			velocity.x = max(velocity.x - ACCELERATION * delta, -MAX_SPEED * delta)
			$WallCast.scale.x = -1
			if canJump:
				$AnimatedSprite2D.play("run")
		else:
			velocity.x = max(velocity.x - ACCELERATION * delta, -MAX_SPEED * delta)
			$WallCast.scale.x = -1
			if canJump:
				$AnimatedSprite2D.play("run")
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		if canJump:
			$AnimatedSprite2D.play("idle")


func dash(delta):
	if !hasDashed:
		if Input.is_action_just_pressed("dash"):
			velocity = input_axis * DASH_SPEED * delta
			spriteColor = "blue"
			Input.start_joy_vibration(0, 1, 1, 0.2)
			isDashing = true
			hasDashed = true

	if isDashing:
		trail = true
		dashTime += 1
		if dashTime >= int(0.25 * 1 / delta):
			isDashing = false
			trail = false
			dashTime = 0

	if is_on_floor() && velocity.y >= 0:
		hasDashed = false
		spriteColor = "red"

func getInputAxis():
	input_axis = Vector2.ZERO
	input_axis.x = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
	input_axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	input_axis = input_axis.normalized()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
func add_fruit(fruit: Node2D) -> void:
	$"../HUD".increment_counter(fruit.color)
	followers.append(fruit)

func _on_area_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Danger"):
		Engine.time_scale = 0.3
		$CollisionShape2D.queue_free()
		$Timer.start()
	elif body.is_in_group("Checkpoint"):
		prev_checkpoint_position = position
	elif body.is_in_group("Door"):
		if has_key(body.id):
			use_key(body.id)
			get_tree().queue_delete(body)

func change_color(color: FruitColor) -> void:
	current_color = color
	var keys_to_erase = []
	for f in followers:
		if f.is_in_group("Key") and f.color != color:
			keys_to_erase.append(f)
	for key in keys_to_erase:
		followers.erase(key)
		key.picked_up = false

func eat_fruit(color: FruitColor) -> void:
	var fruit
	for f in followers:
		if f.is_in_group("Fruit") and f.color == color:
			fruit = f
			break
	if fruit:
		followers.erase(fruit)
		get_tree().queue_delete(fruit)
		
func update_follows(delta: float):
	var parent = self
	for key in followers:
		if abs(key.position.x - parent.position.x) > MIN_X_DISTANCE:
			key.position.x = lerp(key.position.x, parent.position.x, delta*FOLLOW_SPEED)
		if abs(key.position.y - parent.position.y) > MIN_Y_DISTANCE:
			key.position.y = lerp(key.position.y, parent.position.y, delta*FOLLOW_SPEED)
		parent = key
		
func add_key(key: Node2D):
	followers.append(key)	
	
func use_key(id: String):
	var keys_to_delete = []
	for key in followers:
		if key.is_in_group("Key") and key.id == id:
			keys_to_delete.append(key)
	for key in keys_to_delete:
		followers.erase(key)
		get_tree().queue_delete(key)
		
func has_key(id: String):
	var exists = false
	for key in followers:
		if key.is_in_group("Key"):
			exists = exists || key.id == id
	return exists
	
		
		
		
		
		
		
		
		
		
