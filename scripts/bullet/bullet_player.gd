extends Sprite2D

var last_mouse_position: Vector2
var dir: Vector2
const speed: int = 300


func _ready():
	dir = (last_mouse_position - global_position).normalized()


func _physics_process(delta):
	position += dir * speed * delta
