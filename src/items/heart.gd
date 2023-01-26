extends Area2D

class_name Heart



func _ready():
	$AnimationPlayer.play("beat")



func _on_Heart_body_entered(_body):
	set_collision_mask_bit(0,false)
	$SoundCollectHeart.play()
	$AnimationPlayer.play("explode")
	GameManager.increase_hearts()



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":queue_free()
