extends Sprite2D

var last_mouse_position: Vector2
var dir: Vector2
const speed: int = 100


func _ready():
	dir = (last_mouse_position - global_position).normalized()


func _physics_process(delta):
	position += dir * speed * delta


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
