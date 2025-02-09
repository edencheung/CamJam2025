extends CanvasLayer

enum FruitColor {RED, GREEN, BLUE}
var color_of = {
	FruitColor.RED: Color(1, 0, 0, 1),
	FruitColor.GREEN: Color(0, 1, 0, 1),
	FruitColor.BLUE: Color(1, 1, 0, 1)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ReferenceRect.pivot_offset = get_viewport().size / 2

@onready var fruit_color_map = {
	FruitColor.RED: get_node("Counters/RedCounter"),
	FruitColor.GREEN: get_node("Counters/GreenCounter"),
	FruitColor.BLUE: get_node("Counters/BlueCounter")
}

func decrement_counter(color: FruitColor) -> void:
	var counter = fruit_color_map[color]
	counter.text = str(int(counter.text) - 1)

func get_counter(color: FruitColor) -> int:
	return int(fruit_color_map[color].text)
	
func increment_counter(color: FruitColor) -> void:
	var counter = fruit_color_map[color]
	counter.text = str(int(counter.text) + 1)
	
func play_animation(color: FruitColor) -> void:
	$AnimationPlayer.play("enlarge")
	for rect in $ReferenceRect.get_children():
		rect.texture.gradient.set_color(1, color_of[color])
