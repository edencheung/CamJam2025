extends Node2D

@onready var red = $Red
@onready var green = $Green
@onready var blue = $Blue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	
		
func reset():
	red.hide()
	green.hide()
	blue.hide()
	red.collision_enabled = false
	green.collision_enabled = false
	blue.collision_enabled = false
	
func show_color(color: String):
	if color == "red":
		red.show()
		red.collision_enabled = true
	elif color == "green":
		green.show()
		green.collision_enabled = true
	elif color == "blue":
		blue.show()
		blue.collision_enabled = true
