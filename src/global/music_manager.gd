extends Node2D



onready var tween_out = $FadeMusicOut
onready var tween_in = $FadeMusicIn

export var transition_duration : float = 5.0
export var transition_type : int = 1

var music_volume = 0


func fade_out():
	tween_out.interpolate_property($BackgroundMusic, "volume_db", GameManager.music_volume, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()



func fade_in():
	$BackgroundMusic.volume_db = -80
	$BackgroundMusic.play()
	tween_in.interpolate_property($BackgroundMusic, "volume_db", -80, GameManager.music_volume, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_in.start()



func _on_FadeMusicOut_tween_completed(object, _key):
	object.stop()# stop the music -- otherwise it continues to run at silent volume



func HeartBeatMusicIsPlaying() -> bool:
	return $HeartBeatMusic.playing



func HeartBeatMusicStop():
	$HeartBeatMusic.stop()



func HeartBeatMusicPlay():
	$HeartBeatMusic.play()

