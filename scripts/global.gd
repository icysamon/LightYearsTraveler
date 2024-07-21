extends Node2D

@onready var PLANET = preload("res://scene/child/planet.tscn")
@onready var player = $Player
@onready var animation_click = $AnimationClick
@onready var animation_player = $AnimationPlayer

const PLANET_QUANTITY = 100
const DISTANCE_MAX : int = 10000
const R_INCREMENT : int = 100

var creation_radius : int = 300 
var target : Vector2 = Vector2.ZERO
var flag_move : bool = false
var can_move : bool = true
var last_target_normalized : Vector2 = Vector2.ZERO
var planet_array : Array


func _ready():
	# randomly generated planets
	for i in PLANET_QUANTITY:
		var planet = PLANET.instantiate()
		var dir = randi_range(creation_radius, creation_radius + R_INCREMENT) # creation radius
		var deg = randf_range(0, 2 * PI) # creation degree
		var x = cos(deg) * dir
		var y = sin(deg) * dir
		
		
		# random set planet rotation speed
		planet.speed_rotation = randf_range(-1.0, 1.0)
		
		# random set planet scale
		var planet_scale = randf_range(1.0, 1.2)
		planet.scale.x = planet_scale
		planet.scale.y = planet_scale
		
		# set planet random position
		planet.position = Vector2(x, y)
		planet.event = planet.event_array.pick_random()
		add_child(planet)
		
		if planet.get_planet:
			planet.queue_free()
		
		planet_array.append(planet)
		creation_radius += R_INCREMENT
	

func _draw():
	if player.stamina <= 0 and flag_move:
		draw_line(player.global_position, get_global_mouse_position(), Color.BLUE, 3.0)
		

func _process(delta):
	if player.stamina > 0 and flag_move:
		var target_normalized = (target - player.position).normalized()
		player.position += target_normalized * player.speed * delta
	elif player.stamina <= 0:
		queue_redraw()
		
		if flag_move and can_move and Input.is_action_just_pressed("move"):
			can_move = false
			last_target_normalized = (target - player.position).normalized()
			
		elif flag_move and !can_move:
			player.position += last_target_normalized * player.speed * delta
			pass
		
	
	if !animation_player.is_playing():
		animation_click.visible = false
	else:
		animation_click.visible = true
	pass


# input event
func _input(event):
	if event.is_action_pressed("move"):
		#tell system player can be order
		flag_move = true
		
		# set move target
		target = get_global_mouse_position()
		
		# set mouse click animation
		animation_click.position = target
		animation_player.play("click")
	pass
		
