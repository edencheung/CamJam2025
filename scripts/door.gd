extends RigidBody2D

@export var id : String

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
		
func _on_body_entered(body: Node2D) -> void:
	print('hi')
	if body.is_in_group("Player"):
		if body.has_key(id):
			body.use_key(id)
			get_tree().queue_delete(self)
