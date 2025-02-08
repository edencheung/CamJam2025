extends TileMap

@export var player: NodePath  # Assign the player node in the Inspector

var player_node: Node2D

func _ready() -> void:
	# Get the player node from the provided NodePath.
	player_node = get_node(player) as Node2D
	if player_node == null:
		push_error("Player node not assigned or not found!")

func _physics_process(delta: float) -> void:
	# Convert the player's global position to the tilemap's cell coordinate.
	var cell: Vector2i = world_to_map(player_node.global_position)
	
	# Get the tile ID at that cell.
	var tile_id: int = get_cellv(cell)
	if tile_id == -1:
		return  # No tile in this cell; nothing to check.
	
	# Retrieve the custom metadata for this tile.
	var metadata: Dictionary = tile_set.get_tile_metadata(tile_id)
	
	# Check if the tile's metadata includes a deadly property set to true.
	if metadata.has("deadly") and metadata["deadly"]:
		print("Player is colliding with a deadly tile!")
