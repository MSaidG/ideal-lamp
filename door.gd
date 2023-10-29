extends Area2D

func _on_body_entered(body:Node2D):

	if body.get("hasKey"):
		$AnimationPlayer.play("open")


func change_door_state():
	self.name = "Door"
	print("lol")


