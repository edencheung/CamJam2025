extends Node2D

enum FruitColor {RED, GREEN, BLUE}

@onready var fruit_color_map = {
	FruitColor.RED: $Red,
	FruitColor.GREEN: $Green,
	FruitColor.BLUE: $Blue
}

var is_master = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_master:
		var dup = duplicate()
		dup.is_master = false
		get_parent().call_deferred("add_child", dup)
		reset()
	else:
		for elm in fruit_color_map.values():
			for child in elm.get_children():
				child.self_modulate.a = 0
				child.collision_enabled = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	
		
func reset():
	for elm in fruit_color_map.values():
		for child in elm.get_children():
			child.hide()
			child.collision_enabled = false
		
func show_color(color: FruitColor):
	for child in fruit_color_map[color].get_children():
		child.show()
		child.collision_enabled = true
