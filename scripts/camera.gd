extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 10

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

var dest = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0.0, shakeFade * delta)
		
		dest = randomOffset()
		offset = Vector2.ZERO.lerp(dest, 0.5)

func shake():
	shake_strength = randomStrength
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))
