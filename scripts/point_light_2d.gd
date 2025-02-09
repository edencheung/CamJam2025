extends PointLight2D

enum FruitColor {RED, GREEN, BLUE}

const light_colors = {
	FruitColor.RED: Color(1, 0, 0),
	FruitColor.GREEN: Color(0, 1, 0),
	FruitColor.BLUE: Color(1, 1, 0)
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setColor(color: FruitColor):
	self.color = light_colors[color]
	
