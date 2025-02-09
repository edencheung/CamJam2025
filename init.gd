extends Node


var save_path = "user://position.save"

func _ready() -> void:
	var file1 = FileAccess.open(save_path, FileAccess.WRITE)
	file1.store_var(Vector2(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
