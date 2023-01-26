extends Control



const HEART_SIZE : int = 128



func _process(_delta):
	$Score/ScoreApples.text = str(GameManager.player_score_apples)
	$Score/ScoreCoins.text = str(GameManager.player_score_coins)
	$Lifes/HeartContainer.region_rect = Rect2(0,0,GameManager.player_lifes * 64,128)

