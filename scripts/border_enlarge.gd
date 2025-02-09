extends Control

enum FruitColor {RED, GREEN, BLUE}
var color_of = {
	FruitColor.RED: Color(1, 0, 0, 1),
	FruitColor.GREEN: Color(0, 1, 0, 1),
	FruitColor.BLUE: Color(1, 1, 0, 1)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	for rect in $ReferenceRect.get_children():
		var new_texture = rect.texture.duplicate()
		new_texture.set_gradient(new_texture.gradient.duplicate())
		rect.set_texture(new_texture)
		rect.texture.gradient.set_color(1, Color(0, 0, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ReferenceRect.pivot_offset = get_viewport().size / 2
	
func play_animation(color: FruitColor) -> void:
	$AnimationPlayer.play("enlarge")
	await get_tree().create_timer(0.05).timeout
	for rect in $ReferenceRect.get_children():
		rect.texture.gradient.set_color(1, color_of[color])
