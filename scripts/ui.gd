extends Control


@onready var STAMINA_STATUS = $StaminaSystem/MarginContainer/HBoxContainer/Label_Status
@onready var player = $"../.."


func _ready():
	STAMINA_STATUS.text = str(player.stamina)


func _process(delta):
	STAMINA_STATUS.text = str(player.stamina)
	return delta
		
		
func _on_timer_timeout():
	if player.stamina > 0:
		player.stamina -= 1
	pass
