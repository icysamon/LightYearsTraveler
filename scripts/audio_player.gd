extends AudioStreamPlayer2D

var menu_music = preload("res://assets/music/menu/Mixdown/menu.wav")
var main_music = preload("res://assets/music/main/Mixdown/main_head.wav")
var main_music_loop = preload("res://assets/music/main/Mixdown/main_loop.wav")

var flag_main_music: bool = false
var flag_loop: bool = false


func _ready():
	pass
	
	
func _process(delta):
	if !flag_main_music:
		flag_loop = false
		if !is_playing():
			stream = menu_music
			play()
		elif stream == main_music:
			stop()
			stream = menu_music
			play()
	
	return delta
