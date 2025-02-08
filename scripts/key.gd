@tool
extends Area2D

enum FruitColor {RED, GREEN, BLUE}
@export var color : FruitColor
@export var id : String

var picked_up = false

var red_texture = preload("res://sprites/red_sprite_sheet.png")
var green_texture = preload("res://sprites/green_sprite_sheet.png")
var blue_texture = preload("res://sprites/yellow_sprite_sheet.png")

func update_color() -> void:
	if color == FruitColor.RED:
		$Sprite2D.texture.atlas = red_texture
	elif color == FruitColor.GREEN:
		$Sprite2D.texture.atlas = green_texture
	elif color == FruitColor.BLUE:
		$Sprite2D.texture.atlas = blue_texture

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
		body.add_key(self)
		picked_up = true
		
	
