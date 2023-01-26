extends KinematicBody2D

class_name Wisent



const FLOOR_NORMAL = Vector2.UP
export var walking_speed : int = 100
var velocity : Vector2 = Vector2(1, 1)
var bear_is_riding : bool = false
onready var animated_sprite = $wisent
var direction : int = 1


func _physics_process(_delta) -> void:
	velocity.y += GameManager.gravity
	velocity.x = walking_speed * direction
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	if is_on_wall(): direction *= -1
		
	if velocity.x < 0.0: animated_sprite.flip_h = false
	elif velocity.x > 0.0: animated_sprite.flip_h = true
	
	#if velocity.x < 0.0 and is_on_floor(): animated_sprite.play("walk_left")
	#elif velocity.x > 0.0 and is_on_floor(): animated_sprite.play("walk_left")




func _on_Area2D_body_entered(body):
	if body.name.begins_with("bear"): bear_is_riding = true
	
	
	
func _on_Area2D_body_exited(body):
	if body.name.begins_with("bear"): bear_is_riding = false

