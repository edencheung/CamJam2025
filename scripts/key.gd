@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor
@export var id : String

func update_color() -> void:
	if color == FruitColor.RED:
		pass
	elif color == FruitColor.GREEN:
		pass
	elif color == FruitColor.BLUE:
		pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_color()
	
var time: float

func _process(delta: float) -> void:
	time += delta
	if Engine.is_editor_hint():
		update_color()
	else:
		$Sprite2D.scale = Vector2(0.5*(1+sin(time*3.14)), 1)
		
func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint():
		return
	if body.is_in_group("Player"):
		body.add_key(color, id)
		get_tree().queue_delete(self)
		
	
