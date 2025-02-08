extends CanvasLayer

@onready var RED_COUNTER = get_node("Counters/RedCounter")
@onready var GREEN_COUNTER = get_node("Counters/GreenCounter")
@onready var BLUE_COUNTER = get_node("Counters/BlueCounter")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func decrement_counter(color: String) -> void:
	if color == "red":
		RED_COUNTER.text = str(int(RED_COUNTER.text) - 1)
	elif color == "green":
		GREEN_COUNTER.text = str(int(GREEN_COUNTER.text) - 1)
	elif color == "blue":
		BLUE_COUNTER.text = str(int(BLUE_COUNTER.text) - 1)

func get_counter(color: String) -> int:
	if color == "red":
		return int(RED_COUNTER.text)
	elif color == "green":
		return int(GREEN_COUNTER.text)
	elif color == "blue":
		return int(BLUE_COUNTER.text)
	else:
		return -1
	
