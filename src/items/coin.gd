extends Area2D

class_name Coin



func _on_Coin_body_entered(_body):
	set_collision_mask_bit(0,false)
	$AnimationPlayer.play("Bounce")
	GameManager.player_score_coins += 1
	$SoundCoinCollect.play()



func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

