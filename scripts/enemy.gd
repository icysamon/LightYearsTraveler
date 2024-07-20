extends Sprite2D

const SPEED = 45
@onready var BULLET = preload("res://scene/child/bullet.tscn")

var dir = Vector2.ZERO

func _process(delta):
	if get_tree().root.has_node("Node2D/%Player"):
		dir = (get_tree().root.get_node("Node2D/%Player").position - position).normalized()
	return delta
	

func _physics_process(delta):
	position += dir * SPEED * delta


func _on_timer_timeout():
	var bullet = BULLET.instantiate()
	if get_tree().root.has_node("Node2D/%Player"):
		bullet.target_position = get_tree().root.get_node("Node2D/%Player").position
		add_child(bullet)



func _on_area_2d_area_entered(area):
	if area.area_type == "bullet_player":
		queue_free()
	pass # Replace with function body.


func _on_timer_clean_timeout():
	queue_free()
	pass # Replace with function body.
