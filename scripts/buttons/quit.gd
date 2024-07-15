extends Button
@onready var sfx = $"../../../../../SFX"
func _on_button_down():
	sfx.play()
	get_tree().quit()


func _on_mouse_entered():
	sfx.play()
	pass # Replace with function body.
