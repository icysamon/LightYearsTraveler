extends AudioStreamPlayer2D

const menu_music = preload("res://assets/music/menu/Mixdown/menu.wav")
const main_music = preload("res://assets/music/main/Mixdown/main_head.wav")
const main_music_loop = preload("res://assets/music/main/Mixdown/main_loop.wav")

var flag_main_music: bool = false
var flag_loop: bool = false

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
	else:
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
