extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("change_red") or
		Input.is_action_just_pressed("change_blue") or
		Input.is_action_just_pressed("change_green")):
		$colored.reset()

	for color in ["red", "green", "blue"]:
		if Input.is_action_just_pressed("change_%s" % [color]) and $HUD.get_counter(color) > 0:
			$HUD.decrement_counter(color)
			$colored.show_color(color)
