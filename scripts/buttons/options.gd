extends Button
@onready var PATH = "res://scene/main/options.tscn"
@onready var sfx = $"../../../../../SFX"
func _on_button_down():
	get_tree().change_scene_to_file(PATH)


func _on_mouse_entered():
	sfx.play()
	pass # Replace with function body.
