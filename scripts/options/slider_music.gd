extends HSlider

var index

func _ready():
	index = AudioServer.get_bus_index("Music")
	value = db_to_linear(AudioServer.get_bus_volume_db(index))
	
	
func _on_value_changed(value):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	pass # Replace with function body.