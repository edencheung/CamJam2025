extends Node2D

enum FruitColor {RED, GREEN, BLUE}

const fruit_color_to_string = {
	FruitColor.RED: "red",
	FruitColor.GREEN: "green",
	FruitColor.BLUE: "blue"
}

var current_color = null

@onready var platformController = $ColoredPlatforms

var light_scene = preload("res://scenes/point_light_2d.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group('Key'):
			child.set_opacity(0.2)
			
	for tilemap in $Decor.get_children():
		for tile in tilemap.get_used_cells():
			var tile_data = tilemap.get_cell_tile_data(tile)
			var lamp_type = tile_data.get_custom_data("lamp_type")
			var local_pos = tilemap.map_to_local(tile)
			var global_pos = tilemap.to_global(local_pos)
			if lamp_type == "2":
				global_pos.y -= 64
			elif lamp_type == "3":
				global_pos.y -= 32
			var dup = light_scene.instantiate()
			$Lights.call_deferred("add_child", dup)
			dup.position = global_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("change_red") or
		Input.is_action_just_pressed("change_blue") or	
		Input.is_action_just_pressed("change_green")):
		platformController.reset()

	for color in FruitColor.values():
		if Input.is_action_just_pressed("change_%s" % [fruit_color_to_string[color]]):
			if $HUD.get_counter(color) > 0 and current_color != color:
				current_color = color
				change_color(color)
			else:
				$player/Camera2D.shake(10)
			
func change_color(color: FruitColor):
	$HUD.decrement_counter(color)
	platformController.show_color(color)
	$HUD.play_animation(color)
	$player.change_color(color)
	$player.eat_fruit(color)
	for light in $Lights.get_children():
		light.setColor(color)
	for child in get_children():
		if child.is_in_group('Key'):
			if child.color == color:
				child.set_opacity(1)
			else:
				child.set_opacity(0.2)
