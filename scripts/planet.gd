extends Node2D

const TWEEN_SCALE_TIME = 0.1
const SPEED_ROTATION : float = 0.5

var default_scale : Vector2 = Vector2.ONE
var tween_size_add : Vector2 = Vector2.ONE * 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	default_scale = scale

	
func _physics_process(delta):
	rotation += SPEED_ROTATION * delta


func _on_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale + tween_size_add, TWEEN_SCALE_TIME)


func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale, TWEEN_SCALE_TIME)
