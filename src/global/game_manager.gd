# This code is availible everywhere if you put it in
# Project -> Project Settings -> AutoLoad
extends Node



var fullscreen : bool = true
var music_volume : float = 1.0

var game_running : bool = false
var first_level = "res://src/ui/game_screens/game_story.tscn"
var menu_is_active : bool = true

const LEFT = -1
const RIGHT = 1
var gravity : float = 2000
var player_score_apples : int = 0 
var player_score_coins : int = 0
var player_score_total : int = 0
var player_max_lifes : int = 14
var player_lifes : int = 6
var player_position : Vector2 = Vector2.ZERO
var player_direction : int = RIGHT
var player_is_on_stairs : bool = false
var player_is_falling: bool = false
var blobs_hurt : bool = true # After bear met big blob, the small ones won't hurt anymore!




func reset_player():
	player_score_apples = 0
	player_score_coins = 0
	player_score_total = 0
	player_lifes = 6
	game_running = true



func decrase_hearts():
	player_lifes -= 1
	
	if player_lifes <= 2:
		if !MusicManager.HeartBeatMusicIsPlaying():
			MusicManager.fade_out()
			MusicManager.HeartBeatMusicPlay()
	else:
		if MusicManager.HeartBeatMusicIsPlaying():
			MusicManager.fade_in()
			MusicManager.HeartBeatMusicStop()



func increase_hearts():
	if player_lifes < player_max_lifes: player_lifes += 1
	if MusicManager.HeartBeatMusicIsPlaying():
		MusicManager.fade_in()
		MusicManager.HeartBeatMusicStop()



func start_new_game() -> void:
	reset_player()
	game_running = true
	var _err = get_tree().change_scene("res://src/ui/game_screens/game_story.tscn")



func change_level(path):
	var _err = get_tree().change_scene(path)



func quit_game():
	if OS.get_name() == "HTML5":
		JavaScript.eval("window.location.href='https://xn--derkleinebr-u8a.de'")
	else:
		get_tree().quit()
