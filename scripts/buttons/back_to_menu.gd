extends Button
@onready var PATH = "res://scene/main/menu.tscn"
@export var sfx: AudioStreamPlayer
func _on_button_down():
	AudioStreamPlayer2d.flag_main_music = false
	get_tree().change_scene_to_file(PATH)


func _on_mouse_entered():
	sfx.play()
	pass # Replace with function body.
