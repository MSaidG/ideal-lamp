extends Control


signal exit_dialogue_mode()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE



func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_accept"):
		get_parent().visible = false
		emit_signal("exit_dialogue_mode")

func _on_dialogue_visible():
	grab_focus()

