extends Sprite2D

var target_position : Vector2 = Vector2.ZERO
var dir : Vector2 = Vector2.ZERO
const speed : int = 60


func _ready():
	dir = (target_position - global_position).normalized()
	pass


func _physics_process(delta):
	position += dir * speed * delta

func _on_area_2d_area_entered(area):
	if area.area_type == "player":
		area.owner.stamina -= 1
		queue_free()
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
