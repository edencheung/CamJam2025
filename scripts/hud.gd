extends CanvasLayer

enum FruitColor {RED, GREEN, BLUE}
var color_of = {
	FruitColor.RED: Color(1, 0, 0, 1),
	FruitColor.GREEN: Color(0, 1, 0, 1),
	FruitColor.BLUE: Color(1, 1, 0, 1)
}

const BORDER_ENLARGE = preload("res://scenes/border_enlarge.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for rect in $ReferenceRect.get_children():
		rect.texture.gradient.set_color(1, Color(0, 0, 0, 0))

var time: float = 0
const FLUCTUATE_FACTOR = 0.4
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	$ReferenceRect.pivot_offset = get_viewport().size / 2
	$ReferenceRect/Bottom.texture.height = 48 * (1 + FLUCTUATE_FACTOR* sin(time * 3.14))
	$ReferenceRect/Top.texture.height = 48 * (1 + FLUCTUATE_FACTOR* sin(time * 3.14))
	$ReferenceRect/Left.texture.width = 48 * (1 + FLUCTUATE_FACTOR* sin(time * 3.14))
	$ReferenceRect/Right.texture.width = 48 * (1 + FLUCTUATE_FACTOR* sin(time * 3.14))

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
	var ani = BORDER_ENLARGE.instantiate()
	add_child(ani)
	ani.play_animation(color)
	await get_tree().create_timer(0.5).timeout
	get_tree().queue_delete(ani)
	for rect in $ReferenceRect.get_children():
		rect.texture.gradient.set_color(1, color_of[color])

func play_animation_c(color: Color) -> void:
	var ani = BORDER_ENLARGE.instantiate()
	add_child(ani)
	ani.play_animation_c(color)
	await get_tree().create_timer(0.5).timeout
	get_tree().queue_delete(ani)
	for rect in $ReferenceRect.get_children():
		rect.texture.gradient.set_color(1, color)

func get_color(val: float) -> Color:
	var hue = 0 + (val)/10 * 0.8
	print(hue)
	var r = abs(hue * 6 - 3) - 1
	var g = 2 - abs(hue * 6 - 2)
	var b = 2 - abs(hue * 6 - 4)
	r = min(max(r, 0), 1)
	g = min(max(g, 0), 1)
	b = min(max(b, 0), 1)
	return Color(r, g, b, 1)

func play_win() -> void:
	var step = 0
	while true:
		var color = get_color(step % 10)
		step += 1
		play_animation_c(color)
		await get_tree().create_timer(0.2).timeout
