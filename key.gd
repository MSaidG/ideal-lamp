extends Area2D

signal get_key()

func _on_body_entered(body:Node2D):
	print(body.name)
	emit_signal("get_key")
	queue_free()
	# body.get_script().hasKey = true
	# print(body.get_script().hasKey)
