extends Node2D

@onready var key = $Key
@onready var door = $DoorTileMap
@onready var player = $Player

var has_tried_door : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(key)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_player_changed_location():
	
	print(player.position)
	if player.position == Vector2(24, -104) and !has_tried_door:
		key.position += Vector2(-32, 0)
		key.visible = true
		has_tried_door = true

