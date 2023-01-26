extends TextureRect



func _ready():
	$AnimationPlayer.play("intro")



func _on_AnimationPlayer_animation_finished(_anim_name):
	GameManager.change_level("res://src/levels/level_01.tscn")


func _unhandled_input(event):
	if (event is InputEventKey and event.pressed) or \
	   (event is InputEventScreenTouch and event.pressed):
		GameManager.change_level("res://src/levels/level_01.tscn")


func _on_Escape_pressed():
	GameManager.change_level("res://src/levels/level_01.tscn")
