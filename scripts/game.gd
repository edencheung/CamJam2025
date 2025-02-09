extends Node2D

enum FruitColor {RED, GREEN, BLUE}

const fruit_color_to_string = {
	FruitColor.RED: "red",
	FruitColor.GREEN: "green",
	FruitColor.BLUE: "blue"
}

var current_color = null

@onready var platformController = $ColoredPlatforms

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group('Key'):
			child.set_opacity(0.2)
			
	#for tilemap in $Decor.get_children():
		#for tile in tilemap.get_used_cells():
			#ptile)


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
	for child in get_children():
		if child.is_in_group('Key'):
			if child.color == color:
				child.set_opacity(1)
			else:
				child.set_opacity(0.2)
