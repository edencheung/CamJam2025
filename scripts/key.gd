@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor
@export var id : String

var picked_up = false

func update_color() -> void:
	if color == FruitColor.RED:
		$AnimatedSprite2D.play("red")
	elif color == FruitColor.GREEN:
		$AnimatedSprite2D.play("green")
	elif color == FruitColor.BLUE:
		$AnimatedSprite2D.play("blue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_color()
	
var time: float

func _process(delta: float) -> void:
	time += delta
	if Engine.is_editor_hint():
		update_color()
	else:
		$AnimatedSprite2D.scale = Vector2(sin(time*3.14), 1)
		
func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint():
		return
	if picked_up: 
		return
	if body.is_in_group("Player") and body.current_color == color:
		body.add_key(self)
		picked_up = true
		
	
func set_opacity(opacity: float):
	$AnimatedSprite2D.self_modulate.a = opacity
