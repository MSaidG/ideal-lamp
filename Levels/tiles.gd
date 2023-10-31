extends Node

@onready var map_one = $TileMapOne
@onready var map_two = $TileMapTwo

func _ready():
	remove_child(map_one)

func change_dimension():

	if map_one.visible:
		remove_child(map_one)
		add_child(map_two)
		map_two.visible = true
		map_one.visible = false
	else:
		remove_child(map_two)
		add_child(map_one)
		map_two.visible = false
		map_one.visible = true
