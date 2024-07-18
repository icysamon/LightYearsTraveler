extends Control


@onready var battery = $CanvasLayer/StaminaSystem/MarginContainer/Battery
@onready var player = owner


func _ready():
	battery.texture = battery.status[7]


func _process(delta):
	if player.stamina >= 0 and player.stamina <= 11:
		battery.texture = battery.status[player.stamina]
	elif player.stamina < 0:
		battery.texture = battery.status[0]
	else:
		battery.texture = battery.status[11]
	return delta
		
		
func _on_timer_timeout():
	if player.stamina > 0:
		player.stamina -= 1
	pass
