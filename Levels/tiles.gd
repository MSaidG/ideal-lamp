extends Node

@onready var map_one = $TileMapOne
@onready var map_two = $TileMapTwo
@onready var player = get_node("/root/LevelTesting/Player")


func _ready():
	remove_child(map_one)
	
	
func change_dimension():

	var player_position = player.position
	
	if map_one.visible:
		remove_child(map_one)
		add_child(map_two)
		
		var isTwoOkay = check_cell(map_two, player_position)
		if isTwoOkay:
			map_two.visible = true
			map_one.visible = false
		else:
			remove_child(map_two)
			add_child(map_one)


	elif map_two.visible:
		remove_child(map_two)
		add_child(map_one)

		var isOneOkay = check_cell(map_one, player_position)
		if isOneOkay:
			map_two.visible = false
			map_one.visible = true
		else:
			remove_child(map_one)
			add_child(map_two)


func check_cell(map : TileMap, position : Vector2):

	var isCellValid = map.get_cell_tile_data(1, map.local_to_map(position)) != $_NULL

	if isCellValid:
		return map.get_cell_tile_data(1, map.local_to_map(position)).get_collision_polygons_count(0) != 1

	return true
