extends Node2D

@onready var PLANET = preload("res://scene/child/planet.tscn")
@onready var player = $Player

@export var speed = 100

const PLANET_SPRING = preload("res://assets/planet/spring.png")
const PLANET_SUMMER = preload("res://assets/planet/summer.png")
const PLANET_AUTUMN = preload("res://assets/planet/autumn.png")
const PLANET_WINTER = preload("res://assets/planet/winter.png")
const PLANET_HELL0 = preload("res://assets/planet/hell0.png")
const PLANET_BLACK_HOLE = preload("res://assets/planet/black_hole.png")


const PLANET_QUANTITY = 100
const DISTANCE_MAX : int = 10000
const R_INCREMENT : int = 200

var creation_radius : int = 0 
var target : Vector2 = Vector2.ZERO
var flag_move : bool = false
var planet_style = [
	PLANET_SPRING, 
	PLANET_SUMMER, 
	PLANET_AUTUMN,
	PLANET_WINTER,
	PLANET_HELL0,
	PLANET_BLACK_HOLE]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in PLANET_QUANTITY:
		var planet = PLANET.instantiate()	
		var dir = randi_range(creation_radius, creation_radius + R_INCREMENT)
		var deg = randf_range(0, 2 * PI)
		var x = cos(deg) * dir
		var y = sin(deg) * dir
		
		planet.TEXTURE = planet_style.pick_random()
		planet.speed_rotation = randf_range(-1.0, 1.0)
		planet.position = Vector2(x, y)
		add_child(planet)
		
		creation_radius += R_INCREMENT
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag_move:
		var target_normalized = (target - player.position).normalized()
		player.position += target_normalized * speed * delta
	pass
	
func _input(event):
	if event.is_action_pressed("move"):
		flag_move = true
		target = get_global_mouse_position()