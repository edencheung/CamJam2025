@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor
@export var is_packaged : bool = true

var picked_up = false

func update_color() -> void:
	if not is_packaged:
		if color == FruitColor.RED:
			$AnimatedSprite2D.play("red")
		elif color == FruitColor.GREEN:
			$AnimatedSprite2D.play("green")
		elif color == FruitColor.BLUE:
			$AnimatedSprite2D.play("blue")
	else:
		if color == FruitColor.RED:
			$AnimatedSprite2D.play("red_canned")
		elif color == FruitColor.GREEN:
			$AnimatedSprite2D.play("green_canned")
		elif color == FruitColor.BLUE:
			$AnimatedSprite2D.play("blue_canned")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("update_color")
	
var time: float

func _process(delta: float) -> void:
	time += delta
	if Engine.is_editor_hint():
		call_deferred("update_color")
	else:
		$AnimatedSprite2D.scale = Vector2(sin(time*3.14), 1)
		
func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint():
		return
	if picked_up: 
		return
	if body.is_in_group("Player"):
		is_packaged = false
		update_color()
		$CollisionShape2D.queue_free()
		body.add_fruit(self)
		picked_up = true
