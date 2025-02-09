extends RigidBody2D

@export var id : String

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func open():
	$CollisionShape2D.disabled = true
	self.collision_layer = 128
	self.collision_mask = 128
	$AnimationPlayer.play("open")
	
func reset():
	$CollisionShape2D.disabled = false
	self.collision_layer = 1
	self.collision_mask = 1
	$AnimationPlayer.play("close")
