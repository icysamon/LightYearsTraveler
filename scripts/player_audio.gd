extends AudioStreamPlayer
var menu_music = preload("res://assets/music/menu/Mixdown/menu.wav")
var main_music = preload("res://assets/music/main/Mixdown/main_head.wav")
var main_music_loop = preload("res://assets/music/main/Mixdown/main_loop.wav")

var flag_main_music: bool = true
var flag_loop: bool = false

func _ready():
	AudioStreamPlayer2d.stop()
	
func _process(delta):
	if !is_playing() and !flag_loop:
		stream = main_music
		play()
		flag_loop = true
	elif is_playing() and stream == menu_music:
		stop()
		stream = main_music
		flag_loop = true
		play()
	elif !is_playing() and flag_loop:
		stream = main_music_loop
		play()
	
	return delta
