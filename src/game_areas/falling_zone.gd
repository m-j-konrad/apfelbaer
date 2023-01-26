extends Area2D

class_name FallingZone



export var next_level = "res://src/menus/game_over.tscn"



func _on_falling_zone_body_entered(body):
	if body.name == "Bear":
		GameManager.player_is_falling = true
	$FallSound.play()



func _on_FallSound_finished():
	set_physics_process(true)
	GameManager.change_level(next_level)

