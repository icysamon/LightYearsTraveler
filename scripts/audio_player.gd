extends AudioStreamPlayer2D

const music = preload("res://assets/music/menu/Mixdown/menu.wav")

func _process(delta):
	play_music(music)
	return delta

func play_music(music: AudioStream):
	if self.is_playing():
		pass
	else:
		self.play()
