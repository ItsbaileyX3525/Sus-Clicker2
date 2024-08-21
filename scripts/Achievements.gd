extends Node

var timer: float = 0
var oneAllPurchased: bool = true
var hundredMemePurchased: bool = true
var oneTescoPurchased

#Setting up the tracking for the achievements

func clicksChanged(newval: int) -> void:
	trackedData["totalClicks"] = newval
	if newval >= 100 and not bool(achievements[0][1]):
		achievements[0][1] = true
		$"../MainGame/Achievements".playAchievement("Sussy Clicker!", false)
	if newval >= 500 and not bool(achievements[1][1]):
		achievements[1][1] = true
		$"../MainGame/Achievements".playAchievement("Ultra Sussy Clicker!", false)
	if newval >= 7500 and not bool(achievements[2][1]):
		achievements[2][1] = true
		$"../MainGame/Achievements".playAchievement("Omega Ultra Sussy Clicker!", true)

func timeChanged(newval: int) -> void:
	trackedData["totalPlaytime"] = newval
	if is_instance_valid($"../MainGame/Achievements"):
		if newval >= 3600 and not bool(achievements[3][1]):
			achievements[3][1] = true
			$"../MainGame/Achievements".playAchievement("Sus Clicker Enthusiast", false)
		if newval >= 43200 and not bool(achievements[4][1]):
			achievements[4][1] = true
			$"../MainGame/Achievements".playAchievement("Sus Clicker Enjoyer", false)
		if newval >= 129600 and not bool(achievements[5][1]):
			achievements[5][1] = true
			$"../MainGame/Achievements".playAchievement("Sus Clicker God", true)

func accessiveBuyer(newval: int) -> void:
	if newval >= 100 and not bool(achievements[6][1]):
		achievements[6][1] = true
		$"../MainGame/Achievements".playAchievement("Accesive Buyer", false)

func collector() -> void:
	oneAllPurchased = true
	var bought_items = [
		_callumsBought, _nathanielsBought, _taylorsBought, _wilsonsBought, 
		_greensBought, _redsBought, _jermasBought, _floppasBought, 
		_bingusBought, _soggasBought, _maxwellsBought, _ollisBought, 
		_mmmsBought, _keyboardsBought, _mikesBought, _saulsBought, 
		_jessesBought, _gusBought, _hectorsBought, _tucosBought, 
		_waltersBought
	]
	for item in bought_items:
		if item < 1:
			oneAllPurchased = false
			break
	if oneAllPurchased and not achievements[7][1]:
		achievements[7][1] = true
		$"../MainGame/Achievements".playAchievement("Collector", false)

func entrepreneur() -> void:
	var meme_items = [
	_floppasBought, _bingusBought, _soggasBought, _maxwellsBought, 
	_ollisBought, _mmmsBought, _keyboardsBought
	]
	hundredMemePurchased = true
	for item in meme_items:
		if item < 100:
			hundredMemePurchased = false
			break
	if hundredMemePurchased and not achievements[8][1]:
		achievements[8][1] = true
		$"../MainGame/Achievements".playAchievement("Entrepreneur", false)

func soldOut() -> void:
	var tesco_items = [
		_callumsBought, _nathanielsBought, _taylorsBought, _wilsonsBought, 
		_greensBought, _redsBought, _jermasBought
	]
	oneTescoPurchased = true
	for item in tesco_items:
		if item < 1:
			oneTescoPurchased = false
			break
	if oneTescoPurchased and not achievements[9][1]:
		achievements[9][1] = true
		$"../MainGame/Achievements".playAchievement("Sold Out", false)

func shopper(newval) -> void:
	if newval >= 100000 and not achievements[10][1]:
		achievements[10][1] = true
		$"../MainGame/Achievements".playAchievement("Casual Shopper", false)
	if newval >= 1000000000 and not achievements[11][1]:
		achievements[11][1] = true
		$"../MainGame/Achievements".playAchievement("Extreme Shopper", false)
	if newval > 10000000000000 and not achievements[12][1]:
		achievements[12][1] = true
		$"../MainGame/Achievements".playAchievement("Shopaholic", true)


#Logic
var defaultSave: Array = [
	["click100Times", false],
	["click500Times", false],
	["click7500Times", false],
	["played1Hour", false],
	["played12Hours", false],
	["played36Hours", false],
	["accesiveBuyer", false],
	["entrepreneur", false],
	["collector", false],
	["soldOut", false],
	["casualShopper", false],
	["extremeShopper", false],
	["shopaholic", false],
]

var defaultTrackedVariables: Dictionary = {
	"totalClicks": 0,
	"totalPlaytime": 0,
	"totalSpent": 0,
	"callumsBought": 0,
	"nathanielsBought": 0,
	"taylorsBought": 0,
	"wilsonsBought": 0,
	"greensBought": 0,
	"redsBought": 0,
	"jermasBought": 0,
	"floppasBought" : 0,
	"bingusBought" : 0,
	"soggasBought" : 0,
	"maxwellsBought": 0,
	"ollisBought": 0,
	"mmmsBought": 0,
	"keyboardsBought": 0,
	"mikesBought": 0,
	"saulsBought": 0,
	"jessesBought": 0,
	"gusBought": 0,
	"hectorsBought": 0,
	"tucosBought": 0,
	"waltersBought": 0,
}

func saveAchievements(save: Array) -> void:
	var gameFile = FileAccess.open("user://achievements.json", FileAccess.WRITE)
	
	var jsonString = JSON.stringify(save)
	gameFile.store_line(jsonString)

func loadAchievements() -> Array:
	var loadedData
	if not FileAccess.file_exists("user://achievements.json"): 
		return defaultSave
	else:
		var gameSave = FileAccess.get_file_as_string("user://achievements.json")

		loadedData = JSON.parse_string(gameSave)
	
	return loadedData

func saveTrackedData(save: Dictionary) -> void:
	var gameFile = FileAccess.open("user://trackedData.json", FileAccess.WRITE)
	
	var jsonString = JSON.stringify(save)
	gameFile.store_line(jsonString)

func loadTrackedData() -> Dictionary:
	var loadedData
	if not FileAccess.file_exists("user://trackedData.json"): 
		return defaultTrackedVariables
	else:
		var gameSave = FileAccess.get_file_as_string("user://trackedData.json")

		loadedData = JSON.parse_string(gameSave)
	
	return loadedData

var achievements := loadAchievements()
var trackedData := loadTrackedData()

var _totalClicks: int = int(trackedData["totalClicks"]);var _totalPlaytime: int = int(trackedData["totalPlaytime"]);var _totalSpent = int(trackedData["totalSpent"]);var _callumsBought: int = int(trackedData["callumsBought"]);var _nathanielsBought: int = int(trackedData["nathanielsBought"]);var _taylorsBought: int = int(trackedData["taylorsBought"]);var _wilsonsBought: int = int(trackedData["wilsonsBought"]);var _greensBought: int = int(trackedData["greensBought"]);var _redsBought: int = int(trackedData["redsBought"]);var _jermasBought: int = int(trackedData["jermasBought"]);var _floppasBought: int = int(trackedData["floppasBought"]);var _bingusBought: int = int(trackedData["bingusBought"]);var _soggasBought: int = int(trackedData["soggasBought"]);var _maxwellsBought: int = int(trackedData["maxwellsBought"]);var _ollisBought: int = int(trackedData["ollisBought"]);var _mmmsBought: int = int(trackedData["mmmsBought"]);var _keyboardsBought: int = int(trackedData["keyboardsBought"]);var _mikesBought: int = int(trackedData["mikesBought"]);var _saulsBought: int = int(trackedData["saulsBought"]);var _jessesBought: int = int(trackedData["jessesBought"]);var _gusBought: int = int(trackedData["gusBought"]);var _hectorsBought: int = int(trackedData["hectorsBought"]);var _tucosBought: int = int(trackedData["tucosBought"]);var _waltersBought: int = int(trackedData["waltersBought"])

var totalPlaytime: int:
	get:
		return _totalPlaytime
	set(newval):
		_totalPlaytime = newval
		timeChanged(newval)

var totalClicks: int:
	get:
		return _totalClicks
	set(newval):
		_totalClicks = newval
		clicksChanged(newval)

var totalSpent: int:
	get:
		return _totalSpent
	set(newval):
		_totalSpent = newval
		trackedData["totalSpent"] = newval
		shopper(newval)

var callumsBought: int:
	get:
		return _callumsBought
	set(newval):
		_callumsBought = newval
		trackedData["callumsBought"] = newval
		print("Callum bought")
		accessiveBuyer(newval)
		collector()
		soldOut()

var nathanielsBought: int:
	get:
		return _nathanielsBought
	set(newval):
		_nathanielsBought = newval
		trackedData["nathanielsBought"] = newval
		collector()
		soldOut()

var taylorsBought: int:
	get:
		return _taylorsBought
	set(newval):
		_taylorsBought = newval
		trackedData["taylorsBought"] = newval
		collector()
		soldOut()

var wilsonsBought: int:
	get:
		return _wilsonsBought
	set(newval):
		_wilsonsBought = newval
		trackedData["wilsonsBought"] = newval
		collector()
		soldOut()

var greensBought: int:
	get:
		return _greensBought
	set(newval):
		_greensBought = newval
		trackedData["greensBought"] = newval
		collector()
		soldOut()

var redsBought: int:
	get:
		return _redsBought
	set(newval):
		_redsBought = newval
		trackedData["redsBought"] = newval
		collector()
		soldOut()

var jermasBought: int:
	get:
		return _jermasBought
	set(newval):
		_jermasBought = newval
		trackedData["jermasBought"] = newval
		collector()
		soldOut()

var floppasBought: int:
	get:
		return _floppasBought
	set(newval):
		_floppasBought = newval
		trackedData["floppasBought"] = newval
		collector()
		entrepreneur()

var bingusBought: int:
	get:
		return _bingusBought
	set(newval):
		_bingusBought = newval
		trackedData["bingusBought"] = newval
		collector()
		entrepreneur()

var soggasBought: int:
	get:
		return _soggasBought
	set(newval):
		_soggasBought = newval
		trackedData["soggasBought"] = newval
		collector()
		entrepreneur()

var maxwellsBought: int:
	get:
		return _maxwellsBought
	set(newval):
		_maxwellsBought = newval
		trackedData["maxwellsBought"] = newval
		collector()
		entrepreneur()

var ollisBought: int:
	get:
		return _ollisBought
	set(newval):
		_ollisBought = newval
		trackedData["ollisBought"] = newval
		collector()
		entrepreneur()

var mmmsBought: int:
	get:
		return _mmmsBought
	set(newval):
		_mmmsBought = newval
		trackedData["mmmsBought"] = newval
		collector()
		entrepreneur()

var keyboardsBought: int:
	get:
		return _keyboardsBought
	set(newval):
		_keyboardsBought = newval
		trackedData["keyboardsBought"] = newval
		collector()
		entrepreneur()

var mikesBought: int:
	get:
		return _mikesBought
	set(newval):
		_mikesBought = newval
		trackedData["mikesBought"] = newval
		collector()

var saulsBought: int:
	get:
		return _saulsBought
	set(newval):
		_saulsBought = newval
		trackedData["saulsBought"] = newval
		collector()

var jessesBought: int:
	get:
		return _jessesBought
	set(newval):
		_jessesBought = newval
		trackedData["jessesBought"] = newval
		collector()

var gusBought: int:
	get:
		return _gusBought
	set(newval):
		_gusBought = newval
		trackedData["gusBought"] = newval
		collector()

var hectorsBought: int:
	get:
		return _hectorsBought
	set(newval):
		_hectorsBought = newval
		trackedData["hectorsBought"] = newval
		collector()

var tucosBought: int:
	get:
		return _tucosBought
	set(newval):
		_tucosBought = newval
		trackedData["tucosBought"] = newval
		collector()

var waltersBought: int:
	get:
		return _waltersBought
	set(newval):
		_waltersBought = newval
		trackedData["waltersBought"] = newval
		collector()


func _process(delta: float) -> void:
	timer+=delta
	if timer >= 1:
		timer=0
		totalPlaytime+=1
		saveAchievements(achievements)
		saveTrackedData(trackedData)
