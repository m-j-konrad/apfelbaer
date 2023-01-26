extends TextureRect



func _ready():
	GameManager.game_running = false
	$Score/ScoreApples.text = str(GameManager.player_score_apples)
	$Score/ScoreCoins.text = str(GameManager.player_score_coins)
	$Score/ScoreTotal.text = str(GameManager.player_score_apples * GameManager.player_score_coins)
	$AnimationPlayer.play("fadeIn")



func _on_Ja_pressed():
	GameManager.start_new_game()



func _on_Nein_pressed():
	GameManager.quit_game()

