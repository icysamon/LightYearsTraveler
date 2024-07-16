extends Control

const TWEEN_SCALE_TIME = 0.2

func _ready():
	if modulate.a != 0:
		modulate.a = 0
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, TWEEN_SCALE_TIME)


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, TWEEN_SCALE_TIME)
