extends Node2D

enum FruitColor {RED, GREEN, BLUE}


var tilesets = {
	FruitColor.RED: preload("res://sprites/red_sprite_sheet.png"),
	FruitColor.BLUE: preload("res://sprites/yellow_sprite_sheet.png"),
	FruitColor.GREEN: preload("res://sprites/green_sprite_sheet.png")
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_color(color: FruitColor):
	for tilemap in get_children():
		print(tilemap.tile_set)
		for tile_id in tilemap.tile_set.get_tiles_ids():
			tilemap.tile_set.tile_set_texture(tile_id, tilesets[color])
