extends Node2D

@onready var red = $Red
@onready var green = $Green
@onready var blue = $Blue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_8) or Input.is_key_pressed(KEY_9) or Input.is_key_pressed(KEY_0):
		red.hide()
		green.hide()
		blue.hide()
		red.collision_enabled = false
		green.collision_enabled = false
		blue.collision_enabled = false
	if Input.is_key_pressed(KEY_8):
		red.show()
		red.collision_enabled = true
	elif Input.is_key_pressed(KEY_9):
		green.show()
		green.collision_enabled = true
	elif Input.is_key_pressed(KEY_0):
		blue.show()
		blue.collision_enabled = true	
