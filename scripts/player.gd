extends Sprite2D

@onready var GAME_OVER = preload("res://scene/child/game_over.tscn")

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
