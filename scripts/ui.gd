extends Control

@onready var STAMINA_STATUS = $StaminaSystem/MarginContainer/HBoxContainer/Label_Status
var stamina : int = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	STAMINA_STATUS.text = str(stamina)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if stamina > 0:
		stamina -= 1
		STAMINA_STATUS.text = str(stamina)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
