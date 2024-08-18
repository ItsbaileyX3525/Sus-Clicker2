extends Node

var timer: float = 0
var allowSaves: bool = true

var defaultSave := {
	"clicks": 0,
	"multiplier": 1,
	"multiplierCost" : 25000,
	"callumGensBought" : 0,
	"nathanielGensBought" : 0,
	"taylorGensBought" : 0,
	"wilsonGensBought" : 0,
	"redGensBought" : 0,
	"greenGensBought" : 0,
	"jermaGensBought" : 0,
	"floppaGensBought" : 0,
	"bingusGensBought" : 0,
	"soggaGensBought" : 0,
	"maxwellGensBought" : 0,
	"olliGensBought" : 0,
	"mmmmmGensBought" : 0,
	"keyboardGensBought" : 0,
	"mikeGensBought" : 0,
	"saulGensBought" : 0,
	"jesseGensBought" : 0,
	"gusGensBought" : 0,
	"hectorGensBought" : 0,
	"tucoGensBought" : 0,
	"walterGensBought" : 0,
}

func saveGame(save: Dictionary) -> void:
	var gameFile = FileAccess.open("user://gameData.json", FileAccess.WRITE)
	
	var jsonString = JSON.stringify(save)
	gameFile.store_line(jsonString)

func loadGame() -> Dictionary:
	var loadedData
	if not FileAccess.file_exists("user://gameData.json"): 
		return defaultSave
	else:
		var gameSave = FileAccess.get_file_as_string("user://gameData.json")

		loadedData = JSON.parse_string(gameSave)
	
	return loadedData
	
var data := loadGame()

func _ready() -> void:
	pass#justLikeFullyWipeEverythingHeldInData()

func justLikeFullyWipeEverythingHeldInData() -> void:
	allowSaves = false
	DirAccess.remove_absolute("user://gameData.json")

func prestigeWipe() -> void:
	allowSaves = false
	var hasUsername: bool = false
	var username: String
	var oldMultiplier: float = data["multiplier"]
	var oldMultiplierPrice: float = data["multiplierCost"]
	var musicLike: String 
	var vol: String
	if "username" in data:
		hasUsername = true
		username = data["username"]
	if "volume" in data:
		vol = str(data["volume"])
	if "musicChosen" in data:
		musicLike = str(data["musicChosen"])
	
	Generators.prestige()
	data = defaultSave.duplicate()

	if hasUsername:
		data["username"] = username
	data["multiplier"] = oldMultiplier + .5
	data["multiplierCost"] = floor(oldMultiplierPrice * 1.25)
	data["musicChosen"] = musicLike
	data["volume"] = vol
	allowSaves = true	
	
	
func _process(delta: float) -> void:
	timer+=delta
	if timer >= 1 and allowSaves:
		timer=0
		data["lastPlayTime"] = Time.get_unix_time_from_system()
		saveGame(data)
