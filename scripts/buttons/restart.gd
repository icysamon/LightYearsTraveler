extends Button
@export var sfx: AudioStreamPlayer
func _on_button_down():
	AudioStreamPlayer2d.flag_loop = false
	AudioStreamPlayer2d.stop()
	AudioStreamPlayer2d.stream = AudioStreamPlayer2d.main_music
	AudioStreamPlayer2d.play()
	AudioStreamPlayer2d.flag_loop = true
	get_tree().reload_current_scene()


func _on_mouse_entered():
	sfx.play()
	pass # Replace with function body.
