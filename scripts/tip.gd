extends TextureRect

# tween parameter
const TWEEN_SCALE_TIME = 0.2

# label parameter
var event_name
var event_description


func _ready():
	# tip visable init
	if modulate.a != 0:
		modulate.a = 0
	
	# display tip with tween
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, TWEEN_SCALE_TIME)


func _process(delta):
	# update label
	$Name.text = event_name
	$Description.text = event_description
	return delta


func _on_timer_timeout():
	# hide the tip after a certain period of time
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, TWEEN_SCALE_TIME)
