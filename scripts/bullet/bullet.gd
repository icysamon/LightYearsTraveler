extends Sprite2D

var target_position : Vector2 = Vector2.ZERO
var dir : Vector2 = Vector2.ZERO
const speed : int = 60


func _ready():
	dir = (target_position - position).normalized()
	pass


func _physics_process(delta):
	position += dir * speed * delta

func _on_area_2d_area_entered(area):
	if area.area_type == "bullet":
		area.owner.stamina -= 1
	pass
