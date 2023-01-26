extends Node2D

class_name PaintingBucket



export var color = Color(.2, 1, .2)



func _ready():
	$SpriteColor.modulate = color



func _on_ColorChanger_body_entered(body):
	$BlubSound.play()
	body.modulate = color



func _on_ColorChanger_body_exited(_body):
	$BlubSound.play()

