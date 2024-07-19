extends Button
@export var sfx: AudioStreamPlayer
func _on_button_down():
	get_tree().reload_current_scene()


func _on_mouse_entered():
	sfx.play()
	pass # Replace with function body.
