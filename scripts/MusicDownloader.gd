extends Node

@onready var http_request: HTTPRequest = HTTPRequest.new()
var http: HTTPRequest
var fileName: String

func download(link, songName):
	fileName = songName
	fileName = fileName.replace("/", "")
	fileName = fileName.replace(":", "")
	fileName = fileName.replace(".", "")
	var filePath = "user://%s.ogg" % fileName
	if not FileAccess.file_exists(filePath):	
		http = HTTPRequest.new()
		add_child(http)
		http.request_completed.connect(_http_request_completed)
		var request = http.request(link)
		if request != OK:
			push_error("Http request error")
	else:
		var fileLoad = FileAccess.open(filePath, FileAccess.READ)
		var realAudio = fileLoad.get_buffer(fileLoad.get_length())
		MusicPlayer.setCustomMusic(AudioStreamOggVorbis.load_from_buffer(realAudio))

func _http_request_completed(result, _response_code, _headers, body):
	var filePath = "user://%s.ogg" % fileName 
	print(filePath)
	if not FileAccess.file_exists(filePath):
		var fileSave = FileAccess.open(filePath, FileAccess.WRITE)
		print(fileSave)
		fileSave.store_buffer(body)
	if result != OK:
		push_error("Download Failed")
	else:
		var fileLoad = FileAccess.open(filePath, FileAccess.READ)
		var realAudio = fileLoad.get_buffer(fileLoad.get_length())
		MusicPlayer.setCustomMusic(AudioStreamOggVorbis.load_from_buffer(realAudio))
	remove_child(http)
	

func _ready():
	pass
