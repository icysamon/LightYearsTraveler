extends Button
@onready var PATH = "res://scene/main/global.tscn"
func _on_button_down():
	get_tree().change_scene_to_file(PATH)
