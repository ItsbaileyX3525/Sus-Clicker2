extends Node

@onready var musicPlayer: AudioStreamPlayer = AudioStreamPlayer.new()

@onready var musics = [
	preload("res://Assets/audio/music/bg_music.ogg"),
	preload("res://Assets/audio/music/bg_music2.ogg"),
	preload("res://Assets/audio/music/bg_music3.ogg"),
	preload("res://Assets/audio/music/bg_music4.ogg"),
	preload("res://Assets/audio/music/Piers Morgan.ogg"),
	preload("res://Assets/audio/music/ohYeahMrKrabs.ogg"),
	preload("res://Assets/audio/music/spoopyGhost.ogg")
]

func _ready() -> void:
	add_child(musicPlayer)
	musicPlayer.stream = musics[0]
	musicPlayer.play()
	
	
func setMusic(type: int) -> void:
	musicPlayer.stop()
	musicPlayer.stream = musics[type]
	musicPlayer.play()

func setCustomMusic(stream: AudioStreamOggVorbis) -> void:
	stream.loop = true
	musicPlayer.stop()
	musicPlayer.stream = stream
	musicPlayer.play()
