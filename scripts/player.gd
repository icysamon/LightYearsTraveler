extends Sprite2D

@onready var GAME_OVER = preload("res://scene/child/game_over.tscn")

var stamina : int = 1
var area_name = "player"

var flag_game_over : bool = false

func _process(delta):
	# set game over ui
	var game_over = GAME_OVER.instantiate()
	if stamina <= 0 and !flag_game_over:
		flag_game_over = true
		$Camera2D/UI.add_child(game_over)
		$Camera2D/UI.move_child(game_over, 0)
