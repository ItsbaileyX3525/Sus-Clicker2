extends Node2D

var rewarded_ad : RewardedAd
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
var rewarded_ad_load_callback := RewardedAdLoadCallback.new()
var full_screen_content_callback := FullScreenContentCallback.new()

var isGenFrenzy: bool
var isClickGalore: bool

@onready var krabs = [
	$GenFrenzy/Krabs1,
	$ClickGalore/Krabs2
]

@export var isReal: bool = false

func _ready() -> void:
	for e in krabs:
		e.modulate = Color8(90,90,90,255)
	on_user_earned_reward_listener.on_user_earned_reward = on_user_earned_reward
	
	rewarded_ad_load_callback.on_ad_failed_to_load = on_rewarded_ad_failed_to_load
	rewarded_ad_load_callback.on_ad_loaded = on_rewarded_ad_loaded

	full_screen_content_callback.on_ad_clicked = func() -> void:
		print("on_ad_clicked")
	full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		print("on_ad_dismissed_full_screen_content")
		destroy()
		
	full_screen_content_callback.on_ad_failed_to_show_full_screen_content = func(ad_error : AdError) -> void:
		print("on_ad_failed_to_show_full_screen_content")
	full_screen_content_callback.on_ad_impression = func() -> void:
		print("on_ad_impression")
	full_screen_content_callback.on_ad_showed_full_screen_content = func() -> void:
		print("on_ad_showed_full_screen_content")

func _enter_tree() -> void:
	if isReal:
		RewardedAdLoader.new().load("ca-app-pub-9119300254012063/9365526262", AdRequest.new(), rewarded_ad_load_callback)
	else:
		RewardedAdLoader.new().load("ca-app-pub-3940256099942544/1712485313", AdRequest.new(), rewarded_ad_load_callback)

func on_rewarded_ad_failed_to_load(adError : LoadAdError) -> void:
	print(adError.message)
	
func on_rewarded_ad_loaded(rewarded_ad : RewardedAd) -> void:
	for e in krabs:
		e.modulate = Color8(255,255,255,255)
	print("rewarded ad loaded" + str(rewarded_ad._uid))
	rewarded_ad.full_screen_content_callback = full_screen_content_callback

	var server_side_verification_options := ServerSideVerificationOptions.new()
	server_side_verification_options.custom_data = "TEST PURPOSE"
	server_side_verification_options.user_id = "user_id_test"
	rewarded_ad.set_server_side_verification_options(server_side_verification_options)

	self.rewarded_ad = rewarded_ad

func on_user_earned_reward(rewarded_item : RewardedItem) -> void:
	rewarded_ad.destroy()
	rewarded_ad = null
	if isGenFrenzy:
		Generators.grantBoost()
	if isClickGalore:
		Generators.grantClickGalore()
	for e in krabs:
		e.modulate = Color8(90,90,90,255)
	if isReal:
		RewardedAdLoader.new().load("ca-app-pub-9119300254012063/9365526262", AdRequest.new(), rewarded_ad_load_callback)
	else:
		RewardedAdLoader.new().load("ca-app-pub-3940256099942544/1712485313", AdRequest.new(), rewarded_ad_load_callback)

func destroy() -> void:
	if rewarded_ad:
		rewarded_ad.destroy()
		rewarded_ad = null
		for e in krabs:
			e.modulate = Color8(90,90,90,255)

func _on_gen_frenzy_pressed() -> void:
	if rewarded_ad:
		isGenFrenzy = true
		rewarded_ad.show(on_user_earned_reward_listener)

func _on_click_galore_pressed() -> void:
	if rewarded_ad:
		isClickGalore = true
		rewarded_ad.show(on_user_earned_reward_listener)
