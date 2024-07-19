extends Sprite2D

const SPEED = 50
@onready var BULLET = preload("res://scene/child/bullet.tscn")

var dir = Vector2.ZERO

func _process(delta):
	dir = (get_tree().get_nodes_in_group("player")[0].position - position).normalized()
	return delta
	

func _physics_process(delta):
	position += dir * SPEED * delta


func _on_timer_timeout():
	var bullet = BULLET.instantiate()
	bullet.target_position = get_tree().get_nodes_in_group("player")[0].position
	add_child(bullet)
	print(1)



func _on_area_2d_area_entered(area):
	if area.area_type == "bullet_player":
		queue_free()
	pass # Replace with function body.
