extends Node2D


const TWEEN_SCALE_TIME = 0.1

var TIP = preload("res://scene/child/tip.tscn")

@onready var SPRITE2D = $Sprite2D
@onready var GAME_OVER = preload("res://scene/child/game_over.tscn")

@export var texture : Texture
@export var speed_rotation : float = 0.5
@export var event : Resource


enum Type{
	SUPPER_EARTH = 0,
	BARREN = 1,
	HELL = 2,
	BLACK_HOLE = 3
}

enum Season{
	SPRING = 0,
	SUMMER = 1,
	AUTUMN = 2,
	WINTER = 3
}

var planet_type_array : Array[Texture] = [
	preload("res://assets/planet/hell0.png"),
	preload("res://assets/planet/black_hole.png"),
	preload("res://assets/planet/black_hole.png"),
	preload("res://assets/planet/black_hole.png")
	]

var planet_season_array : Array[Texture] = [
	preload("res://assets/planet/spring.png"),
	preload("res://assets/planet/summer.png"),
	preload("res://assets/planet/autumn.png"),
	preload("res://assets/planet/winter.png"),
]

var planet_type
var planet_season

@export var event_array : Array[Resource]

# tween
var default_scale : Vector2 = Vector2.ONE
var tween_size_add : Vector2 = Vector2.ONE * 0.2

var planet_energy : int = 10

# area node
var get_player : bool = false
var get_planet : bool = false
var player
var area_name = "planet"
var flag_tip : bool = false
var flag_first_enter : bool = false

func _ready():
	default_scale = scale
	
	# random set planet type
	$Sprite2D.texture = planet_type_array.pick_random()
	for i in planet_type_array.size():
		if $Sprite2D.texture == planet_type_array[i]:
			planet_type = i
			break
	
	# set planet season if it is super earth
	if planet_type == Type.SUPPER_EARTH:
		$Sprite2D.texture = planet_season_array.pick_random()
		for i in planet_type_array.size():
			if $Sprite2D.texture == planet_season_array[i]:
				planet_season = i
				break
		

func _physics_process(delta):
	# planet rotation
	rotation += speed_rotation * delta


# self function
func _probability(percent : float = 0.50):
	var threshold : float = randf()
	if threshold < percent:
		return true
	else:
		return false


func _on_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale + tween_size_add, TWEEN_SCALE_TIME)


func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale, TWEEN_SCALE_TIME)


func _on_area_2d_area_entered(area):
	# get player node
	if area.area_type == "player":
		player = area.owner # get player parent node
		get_planet = false
		get_player = true
		
		# Display planet's event when player first enter
		if not flag_first_enter:
			flag_first_enter = true
			var tip = TIP.instantiate()

			# set tip information
			tip.event_name = event.name
			tip.event_description = event.description
			player.get_node("Camera2D/UI").add_child(tip)
		
	elif area.area_type == "planet":
		get_player = false
		get_planet = true	
	pass


func _on_timer_timeout():
	match planet_type:
		Type.SUPPER_EARTH:
			if _probability(0.3):
				$Sprite2D.texture = planet_type_array[Type.HELL]
				planet_type = Type.HELL
		Type.BARREN:
			if _probability(0.3):
				$Sprite2D.texture = planet_type_array[Type.HELL]
				planet_type = Type.HELL
		Type.HELL:
			if _probability(0.3):
				$Sprite2D.texture = planet_type_array[Type.SUPPER_EARTH]
				planet_type = Type.SUPPER_EARTH
			else:
				$Sprite2D.texture = planet_type_array[Type.BLACK_HOLE]
				planet_type = Type.BLACK_HOLE
		Type.BLACK_HOLE:
			if _probability(0.3):
				$Sprite2D.texture = planet_type_array[Type.HELL]
				planet_type = Type.HELL
				
	if planet_type == Type.SUPPER_EARTH:
		match planet_season:
			Season.SPRING:
				$Sprite2D.texture = planet_season_array[Season.SUMMER]
			Season.SUMMER:
				$Sprite2D.texture = planet_season_array[Season.AUTUMN]
			Season.AUTUMN:
				$Sprite2D.texture = planet_season_array[Season.WINTER]
			Season.WINTER:
				$Sprite2D.texture = planet_season_array[Season.SPRING]
	

func _on_timer_stamina_timeout():
	if get_player and planet_energy > 0 and player.stamina != null:
		match planet_type:
			Type.SUPPER_EARTH:
				match planet_season:
					Season.SPRING:
						player.stamina += 3
						planet_energy -= 3
					Season.SUMMER:
						player.stamina += 2
						planet_energy -= 2
					Season.AUTUMN:
						player.stamina += 1
						planet_energy -= 1
					Season.WINTER:
						player.stamina += 1
						planet_energy -= 2
			Type.SUPPER_EARTH:
				player.stamina -= 10000


	elif get_player and planet_energy <= 0:
		if !flag_tip:
			flag_tip = true
			var tip = TIP.instantiate()
			tip.scale = Vector2.ONE * 0.5
			get_tree().root.get_node("Node2D/Player/Camera2D").add_child(tip)
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if area.area_type == "player":
		get_player = false
		flag_tip = false
	pass # Replace with function body.
