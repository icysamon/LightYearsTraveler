extends Sprite2D

@onready var GAME_OVER = preload("res://scene/child/game_over.tscn")
@onready var BULLET_PLAYER = preload("res://scene/child/bullet_player.tscn")
@onready var ENEMY = preload("res://scene/child/enemy.tscn")

var stamina : int = 11
var area_name = "player"
var speed : int = 120

var flag_game_over : bool = false



func _process(delta):
	# set game over ui
	var game_over = GAME_OVER.instantiate()
	if stamina <= 0 and !flag_game_over:
		flag_game_over = true
		$Camera2D/UI.add_child(game_over)
		$Camera2D/UI.move_child(game_over, 0)
	return delta
	
func _input(event):
	if event.is_action_pressed("zoom in"):
		if $Camera2D.zoom.x < 1:
			$Camera2D.zoom += 0.2 * Vector2.ONE
	if event.is_action_pressed("zoom out"):
		if $Camera2D.zoom.x > 0.2:
			$Camera2D.zoom -= 0.2 * Vector2.ONE
	if event.is_action_pressed("attack"):
		var bullet_player = BULLET_PLAYER.instantiate()
		bullet_player.last_mouse_position = get_global_mouse_position()
		add_child(bullet_player)
		pass


func _on_timer_timeout():
	var enemy = ENEMY.instantiate()
	var dir = Vector2.ONE * 500
	var random_array: Array[int] = [1, -1]
	enemy.position = position + Vector2(
		dir.x * random_array.pick_random(), dir.y * random_array.pick_random())
	get_tree().root.get_node("Node2D/%Enemy").add_child(enemy)
	
	pass # Replace with function body.
