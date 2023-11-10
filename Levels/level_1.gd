extends Node2D

signal dialogue_visible()
signal enter_dialogue_mode()

@onready var key = $Key
@onready var door = $DoorTileMap
@onready var player = $Player
@onready var ui = $UI

var has_tried_door : bool = false


func _on_player_changed_location():
	
	print(player.position)
	if player.position == Vector2(24, -104) and !has_tried_door:
		key.position += Vector2(-32, 0)
		key.visible = true
		has_tried_door = true
	
	if player.position == Vector2(24, -72) and has_tried_door:
		ui.visible = true
		emit_signal("dialogue_visible")
		emit_signal("enter_dialogue_mode")


func on_changed_dimension(num):

	if num == 1:
		add_child(key)
	else:
		remove_child(key)
