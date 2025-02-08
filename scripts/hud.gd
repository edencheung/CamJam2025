extends CanvasLayer

enum FruitColor {RED, GREEN, BLUE}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
