extends Area2D

class_name Apple 



var apple_texture1 = preload("res://src/items/graphics/apple_01.png")
var apple_texture2 = preload("res://src/items/graphics/apple_02.png")
var apple_texture3 = preload("res://src/items/graphics/apple_03.png")
var apple_texture4 = preload("res://src/items/graphics/apple_04.png")

var rng = RandomNumberGenerator.new()



"""
Randomize allpe sprite textures and start bouncing animation
"""
func _ready() -> void:
	rng.randomize()
	var i := randi()%4+1
	match i:
		1: $Apple.texture = apple_texture1
		2: $Apple.texture = apple_texture2
		3: $Apple.texture = apple_texture3
		4: $Apple.texture = apple_texture4
	$AnimationPlayer.play("hanging")



"""
Play animation (the magic will happen when animation is finished)
"""
func _on_Apple_body_entered(_body):
	set_collision_mask_bit(0,false)
	$SoundGrabApple.play()
	$AnimationPlayer.play("fly_away")



"""
Give bear an apple and delete apple in scene
"""
func _on_AnimationPlayer_animation_finished(_anim_name):
	GameManager.player_score_apples += 1
	queue_free()

