extends Sprite2D

const SPEED = 50

var dir = Vector2.ZERO

func _process(delta):
	dir = (get_tree().get_nodes_in_group("player")[0].position - position).normalized()
	
	pass
func _physics_process(delta):
	position += dir * SPEED * delta
