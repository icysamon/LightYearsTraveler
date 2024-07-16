extends Node2D

const TWEEN_SCALE_TIME = 0.1

var TIP = preload("res://scene/child/tip.tscn")
@onready var SPRITE2D = $Sprite2D
@export var TEXTURE : Texture
@export var speed_rotation : float = 0.5

const PLANET_SPRING = preload("res://assets/planet/spring.png")
const PLANET_SUMMER = preload("res://assets/planet/summer.png")
const PLANET_AUTUMN = preload("res://assets/planet/autumn.png")
const PLANET_WINTER = preload("res://assets/planet/winter.png")
const PLANET_HELL0 = preload("res://assets/planet/hell0.png")
const PLANET_BLACK_HOLE = preload("res://assets/planet/black_hole.png")

var planet_style = [
	PLANET_SPRING, 
	PLANET_SUMMER, 
	PLANET_AUTUMN,
	PLANET_WINTER,
	PLANET_HELL0,
	PLANET_BLACK_HOLE]

var default_scale : Vector2 = Vector2.ONE
var tween_size_add : Vector2 = Vector2.ONE * 0.2

var status : String = "null"
var planet_energy : int = 10

# area node
var get_player : bool = false
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	default_scale = scale
	SPRITE2D.texture = TEXTURE
	match SPRITE2D.texture:
		PLANET_SPRING: status = "spring"
		PLANET_SUMMER: status = "summer"
		PLANET_AUTUMN: status = "autumn"
		PLANET_WINTER: status = "winter"
		PLANET_HELL0: status = "hello"
		PLANET_BLACK_HOLE: status = "black_hole"
		

func _physics_process(delta):
	rotation += speed_rotation * delta


func _on_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale + tween_size_add, TWEEN_SCALE_TIME)


func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale, TWEEN_SCALE_TIME)


func _on_area_2d_area_entered(area):
	# get player node
	player = area.owner
	get_player = true


func _on_timer_timeout():
	match SPRITE2D.texture:
		PLANET_SPRING:
			SPRITE2D.texture = PLANET_SUMMER
			status = "summer"
		PLANET_SUMMER:
			SPRITE2D.texture = PLANET_AUTUMN
			status = "autumn"
		PLANET_AUTUMN:
			SPRITE2D.texture = PLANET_WINTER
			status = "winter"
		PLANET_WINTER:
			SPRITE2D.texture = PLANET_HELL0
			status = "hell0"
		PLANET_HELL0:
			SPRITE2D.texture = PLANET_BLACK_HOLE
			status = "black_hole"
		PLANET_BLACK_HOLE:
			SPRITE2D.texture = planet_style.pick_random()
			match SPRITE2D.texture:
				PLANET_SPRING: status = "spring"
				PLANET_SUMMER: status = "summer"
				PLANET_AUTUMN: status = "autumn"
				PLANET_WINTER: status = "winter"
				PLANET_HELL0: status = "hello"
				PLANET_BLACK_HOLE: status = "black_hole"
	pass # Replace with function body.


func _on_timer_stamina_timeout():
	if get_player and planet_energy > 0 and player.stamina != null:
		match SPRITE2D.texture:
			PLANET_SPRING:
				player.stamina += 3
				planet_energy -= 3
			PLANET_SUMMER:
				player.stamina += 2
				planet_energy -= 2
			PLANET_AUTUMN:
				player.stamina += 1
				planet_energy -= 1
			PLANET_WINTER:
				pass
	elif get_player and planet_energy <= 0:
		var tip = TIP.instantiate()
		get_tree().root.get_node("Node2D/Player/Camera2D").add_child(tip)
	pass # Replace with function body.
