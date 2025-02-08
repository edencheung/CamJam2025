extends Node2D

enum FruitColor {RED, GREEN, BLUE}

const fruit_color_to_string = {
	FruitColor.RED: "red",
	FruitColor.GREEN: "green",
	FruitColor.BLUE: "blue"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("change_red") or
		Input.is_action_just_pressed("change_blue") or
		Input.is_action_just_pressed("change_green")):
		$colored.reset()

	for color in FruitColor.values():
		if Input.is_action_just_pressed("change_%s" % [fruit_color_to_string[color]]) and $HUD.get_counter(color) > 0:
			change_color(color)
			
func change_color(color: FruitColor):
	$HUD.decrement_counter(color)
	$colored.show_color(color)
	$player.change_color(color)
	for child in get_children():
		if child.is_in_group('Key'):
			if child.color == color:
				child.show()
			else:
				child.hide()
