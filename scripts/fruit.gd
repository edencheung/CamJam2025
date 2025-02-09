@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor
@export var is_packaged : bool = true

var picked_up = false

func update_color() -> void:
	if not is_packaged:
		if color == FruitColor.RED:
			$Sprite2D.texture.set_region(Rect2(0, 0, 32, 32))
		elif color == FruitColor.GREEN:
			$Sprite2D.texture.set_region(Rect2(0, 0, 32, 32))
		elif color == FruitColor.BLUE:
			$Sprite2D.texture.set_region(Rect2(0, 0, 32, 32))
	else:
		if color == FruitColor.RED:
			$Sprite2D.texture.set_region(Rect2(0, 0, 32, 32))
		elif color == FruitColor.GREEN:
			$Sprite2D.texture.set_region(Rect2(64, 0, 32, 32))
		elif color == FruitColor.BLUE:
			$Sprite2D.texture.set_region(Rect2(32, 0, 32, 32))

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
	if picked_up: 
		return
	if body.is_in_group("Player"):
		body.add_fruit(self)
		picked_up = true
		
	
