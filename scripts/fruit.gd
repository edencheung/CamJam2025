@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor

func update_color() -> void:
	if color == FruitColor.RED:
		$Sprite2D.texture.set_region(Rect2(0, 48, 16, 16))
	elif color == FruitColor.GREEN:
		$Sprite2D.texture.set_region(Rect2(0, 0, 16, 16))
	elif color == FruitColor.BLUE:
		$Sprite2D.texture.set_region(Rect2(0, 32, 16, 16))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_color()
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		update_color()
		


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().queue_delete(self)
		
