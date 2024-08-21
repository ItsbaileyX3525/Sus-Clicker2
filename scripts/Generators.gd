extends Node

var timer: float = 0
var firstLoad: bool = false
var earnTimer: float = 1
var boosting: bool = false
var boostingGalore: bool = false
var offlineEarnings: float
var clickGalore: bool = false

var callumGensBought: int = 0
var nathanielGensBought: int = 0
var taylorGensBought: int = 0
var wilsonGensBought: int = 0
var greenGensBought: int = 0
var redGensBought: int = 0
var jermaGensBought: int = 0
var floppaGensBought: int = 0
var bingusGensBought: int = 0
var soggaGensBought: int = 0
var maxwellGensBought: int = 0
var olliGensBought: int = 0
var mmmmGensBought: int = 0
var keyboardGensBought: int = 0
var mikeGensBought: int = 0
var saulGensBought: int = 0
var jesseGensBought: int = 0
var gusGensBought: int = 0
var hectorGensBought: int = 0
var tucoGensBought: int = 0
var walterGensBought: int = 0

var generatorVars = [
	"callumGensBought", "nathanielGensBought", "taylorGensBought", "wilsonGensBought", 
	"greenGensBought", "redGensBought", "jermaGensBought", "floppaGensBought", 
	"bingusGensBought", "soggaGensBought", "maxwellGensBought", "olliGensBought", 
	"mmmmGensBought", "keyboardGensBought", "mikeGensBought", "saulGensBought",
	"jesseGensBought", "gusGensBought", "hectorGensBought", "walterGensBought",
	
]

func loadData(key: String, data: Dictionary = SaveGame.data) -> int:
	if key in data:
		return data[key]
	else:
		data[key] = 0
		return 0

func grantBoost() -> void:
	if not boosting:
		boosting = true
		earnTimer = 0.3
		await get_tree().create_timer(30).timeout
		earnTimer = 1
		boosting = false

func grantClickGalore() -> void:
	if not boostingGalore:
		clickGalore = true
		await get_tree().create_timer(45).timeout
		boostingGalore=false
		clickGalore=false

func prestige() -> bool:
	for var_name in generatorVars:
		self.set(var_name, 0)
	return true
	
func calcOfflineEarnings() -> void:
	if not firstLoad:
		offlineEarnings += 1 * SaveGame.data["callumGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 3 * SaveGame.data["nathanielGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 9 * SaveGame.data["taylorGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 27 * SaveGame.data["wilsonGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 81 * SaveGame.data["greenGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 243 * SaveGame.data["redGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 729 * SaveGame.data["jermaGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 2187 * SaveGame.data["floppaGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 6561 * SaveGame.data["bingusGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 19683 * SaveGame.data["soggaGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 59049 * SaveGame.data["maxwellGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 177147 * SaveGame.data["olliGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 531441 * SaveGame.data["mmmmmGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 1594323 * SaveGame.data["keyboardGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 4782969 * SaveGame.data["mikeGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 14348907 * SaveGame.data["saulGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 43046721 * SaveGame.data["jesseGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 129140163 * SaveGame.data["gusGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 387420489 * SaveGame.data["hectorGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 1162261467 * SaveGame.data["tucoGensBought"] * SaveGame.data["multiplier"]
		offlineEarnings += 3486784401 * SaveGame.data["walterGensBought"] * SaveGame.data["multiplier"]
	
func _process(delta: float) -> void:
	timer+=delta
	if timer >= earnTimer:
		timer = 0
		var temp = SaveGame.data
		if not firstLoad:
			for varName in generatorVars:
				self.set(varName, loadData(varName, temp))
			firstLoad = true
		SaveGame.data["callumGensBought"] = callumGensBought
		SaveGame.data["nathanielGensBought"] = nathanielGensBought
		SaveGame.data["taylorGensBought"] = taylorGensBought
		SaveGame.data["wilsonGensBought"] = wilsonGensBought
		SaveGame.data["greenGensBought"] = greenGensBought
		SaveGame.data["redGensBought"] = redGensBought
		SaveGame.data["jermaGensBought"] = jermaGensBought
		SaveGame.data["floppaGensBought"] = floppaGensBought
		SaveGame.data["bingusGensBought"] = bingusGensBought
		SaveGame.data["soggaGensBought"] = soggaGensBought
		SaveGame.data["maxwellGensBought"] = maxwellGensBought
		SaveGame.data["olliGensBought"] = olliGensBought
		SaveGame.data["mmmmmGensBought"] = mmmmGensBought
		SaveGame.data["keyboardGensBought"] = keyboardGensBought
		SaveGame.data["mikeGensBought"] = mikeGensBought
		SaveGame.data["saulGensBought"] = saulGensBought
		SaveGame.data["jesseGensBought"] = jesseGensBought
		SaveGame.data["gusGensBought"] = gusGensBought
		SaveGame.data["hectorGensBought"] = hectorGensBought
		SaveGame.data["tucoGensBought"] = tucoGensBought
		SaveGame.data["walterGensBought"] = walterGensBought
		
	
		SaveGame.data["clicks"] += 1 * callumGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 3 * nathanielGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 9 * taylorGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 27 * wilsonGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 81 * greenGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 243 * redGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 729 * jermaGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 2187 * floppaGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 6561 * bingusGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 19683 * soggaGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 59049 * maxwellGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 177147 * olliGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 531441 * mmmmGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 1594323 * keyboardGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 4782969 * mikeGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 14348907 * saulGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 43046721 * jesseGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 129140163 * gusGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 387420489 * hectorGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 1162261467 * tucoGensBought * SaveGame.data["multiplier"]
		SaveGame.data["clicks"] += 3486784401 * walterGensBought * SaveGame.data["multiplier"]
		
