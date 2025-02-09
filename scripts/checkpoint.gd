extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var activated = false	
	
func activate_checkpoint():
	print("hi")
	if activated: 
		return
	activated = true
	$AnimationPlayer.play("lights_on")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.checkpoint_entered(self)
		activate_checkpoint()
