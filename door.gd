extends Area2D

func _on_body_entered(body:Node2D):

	print(body.name)
	if body.get("hasKey"):
		$AnimationPlayer.play("open")


func change_door_state(): # Connected from key

	# DoorTileMap to door
	self.name = "Door"
	print("lol")


