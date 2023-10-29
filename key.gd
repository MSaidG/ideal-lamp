extends Area2D

signal get_key()
signal change_door_state()

func _on_body_entered(_body:Node2D):
	emit_signal("get_key")
	emit_signal("change_door_state")
	queue_free()
