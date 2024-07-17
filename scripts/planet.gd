extends Node2D

@onready var TIP = preload("res://scene/child/tip.tscn")
@onready var SPRITE2D = $Sprite2D
@onready var GAME_OVER = preload("res://scene/child/game_over.tscn")

@export var texture : Texture
@export var speed_rotation : float = 0.5
@export var event : Resource
@export var event_array : Array[Resource]
@export var default_planet : bool = false
@export var in_menu : bool = false
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

# planet type
var planet_type
var planet_type_array : Array[Texture] = [
	preload("res://assets/planet/spring.png"),
	preload("res://assets/planet/hell0.png"),
	preload("res://assets/planet/hell0.png"),
	preload("res://assets/planet/black_hole.png")
	]

# planet season
var planet_season
var planet_season_array : Array[Texture] = [
	preload("res://assets/planet/spring.png"),
	preload("res://assets/planet/summer.png"),
	preload("res://assets/planet/autumn.png"),
	preload("res://assets/planet/winter.png"),
]

# tween
var default_scale : Vector2 = Vector2.ONE
var tween_size_add : Vector2 = Vector2.ONE * 0.2

# planet parameter
var planet_energy : int = 10
const TWEEN_SCALE_TIME : float = 0.1

# area node
var player
var area_name : String = "planet"
var get_player : bool = false
var get_planet : bool = false
var flag_tip : bool = false
var flag_first_enter : bool = false
var tip_temp
func _ready():
	default_scale = scale

	# random set planet type
	if !default_planet:
		$Sprite2D.texture = planet_type_array.pick_random()
		for i in planet_type_array.size():
			if $Sprite2D.texture == planet_type_array[i]:
				planet_type = i
				break
	# default planet
	else:
		$Sprite2D.texture = texture
		planet_type = Type.SUPPER_EARTH
		planet_season = Season.SPRING
		if !$Sprite2D.texture:
			$Sprite2D.texture = planet_type_array[Type.SUPPER_EARTH]
	
	# set planet season if it is super earth
	if planet_type == Type.SUPPER_EARTH and !default_planet:
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
	if threshold < percent: return true
	else: return false


func _on_mouse_entered():
	# tween animation when mouse entered
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale + tween_size_add, TWEEN_SCALE_TIME)
	
	# set tip information
	if default_planet and in_menu:
		var tip = TIP.instantiate()
		tip.event_name = event.name
		tip.event_description = event.description
		owner.add_child(tip)
		tip_temp = tip


func _on_mouse_exited():
	# tween animation when mouse exited
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale, TWEEN_SCALE_TIME)
	
	if default_planet and in_menu and tip_temp != null:
		tip_temp.queue_free()


func _on_area_2d_area_entered(area):
	# get player node
	if area.area_type == "player":
		player = area.owner # get player parent node
		get_planet = false
		get_player = true
		
		# Display planet's event when player first enter
		if not flag_first_enter:
			flag_first_enter = true
			
			# set tip information
			var tip = TIP.instantiate()
			tip.event_name = event.name
			tip.event_description = event.description
			player.get_node("Camera2D/UI").add_child(tip)
	
	# when get planet (error status)	
	elif area.area_type == "planet":
		push_warning("planet to planet collision!")
		get_player = false
		get_planet = true	
	pass


func _on_timer_timeout():
	# random change planet type
	if !default_planet:
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


	# change supper earth season	
	if planet_type == Type.SUPPER_EARTH and !default_planet:
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
		# stamina
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

	# game over
	elif get_player and planet_energy <= 0:
		if !flag_tip:
			flag_tip = true
			# display event: "you should leave"
			var tip = TIP.instantiate()
			event = load("res://resource/event/you_should_leave.tres")
			tip.event_name = event.name
			tip.event_description = event.description
			player.get_node("Camera2D/UI").add_child(tip)
	pass


func _on_area_2d_area_exited(area):
	# when player leave planet
	if area.area_type == "player":
		get_player = false
		flag_tip = false
	pass
