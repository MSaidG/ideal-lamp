extends Area2D

signal get_key()
signal change_door_state()

func _on_body_entered(body:Node2D):
	if body.name == "Player":
		emit_signal("get_key")
		emit_signal("change_door_state")
		queue_free()
