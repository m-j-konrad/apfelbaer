extends KinematicBody2D

class_name bear



const FLOOR_NORMAL = Vector2.UP

export var speed := Vector2(300.0, 595.0)
export var velocity := Vector2.ZERO
export var max_idle : int = 400

var idle_timer : int = 0
onready var animated_sprite = $AnimatedSprite
var jump_started = false
var is_on_stairs : bool = false
var hurt : int = 0
var bear_color
var is_jump_interrupted : bool = false



func _ready():
	if GameManager.player_lifes <= 2:
		if !MusicManager.HeartBeatMusicIsPlaying():
			MusicManager.fade_out()
			MusicManager.HeartBeatMusicPlay()
	else:
		if MusicManager.HeartBeatMusicIsPlaying():
			MusicManager.fade_in()
			MusicManager.HeartBeatMusicStop()
			
	set_physics_process(true)
	# MusicManager.fade_in()



func _physics_process(_delta):
	if Input.is_action_just_pressed("esc"):
		if !GameManager.menu_is_active: show_menu()
		else: hide_menu()
		
	if Input.is_action_just_pressed("help"):
		$Screen/MainMenu/Help.show()
	
	var direction := get_direction()
	
	is_jump_interrupted = (Input.is_action_just_released("up") or is_on_ceiling()) and velocity.y < 0.0
	
	if Input.is_action_pressed("up") and is_on_floor(): $JumpSound.play()
	
	velocity = calculate_velocity(velocity, direction)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	if is_on_floor() == false:
		idle_timer = 0
		animated_sprite.play("jump")
	
	if direction.x < 0.0: animated_sprite.flip_h = true
	if direction.x > 0.0: animated_sprite.flip_h = false
	
	if direction.x < 0.0 and is_on_floor():
		idle_timer = 0
		animated_sprite.play("walk")
	
	if direction.x > 0.0 and is_on_floor():
		idle_timer = 0
		animated_sprite.play("walk")
	
	if direction.x == 0 and is_on_floor():
		idle_timer += 1
		if idle_timer >= max_idle:
			if idle_timer < max_idle * 3: animated_sprite.play("look_around")
			else: animated_sprite.play("sit")
		else:
			animated_sprite.play("idle")
	
	GameManager.player_position = self.position
	
	if GameManager.player_is_falling:
		GameManager.player_is_falling = false
		set_physics_process(false)



func get_direction() -> Vector2:
	GameManager.player_direction = -1 if Input.is_action_pressed("up") and is_on_floor() else 1
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		GameManager.player_direction
	)



func calculate_velocity(
		linear_velocity: Vector2,
		direction: Vector2
	) -> Vector2:
	
	var out := linear_velocity
	out.x = speed.x * direction.x

	if direction.y == -1.0:
		out.y = speed.y * direction.y
	
	if direction.y == 1:
		out.y += (GameManager.gravity / 2) * get_physics_process_delta_time()
	
	if is_jump_interrupted:
		out.y = 0.0
	return out



func bounce():
	var bounce_force = 1.8
	#if Input.is_action_pressed("up"):
	#	bounce_force = 2.3
	#	is_jump_interrupted = true
	
	if velocity.y < 0: velocity.y += velocity.y * bounce_force
	else: velocity.y += velocity.y * -bounce_force
	
	#FÜR SPRUNGFEDERN:
	#if velocity.y < 0: velocity.y += velocity.y * -5
	#else: velocity.y += velocity.y * -5



func ouch(var enemy_pos_x):
	set_collision_layer_bit(0, false)
	GameManager.decrase_hearts()
	if GameManager.player_lifes <= 0:
		set_physics_process(false)
		$GameOverSound.play()
		$AnimationPlayer.play("wake_up") # after animation finished, game over screen
	else:
		if self.position.x < enemy_pos_x: self.velocity.x -= speed.x * .5
		elif self.position.x > enemy_pos_x: self.velocity.x += speed.x * .5
		bounce()
		Input.action_release("left")
		Input.action_release("right")
		Input.action_release("up")
		
		bear_color = self.modulate
		$AnimatedSprite.play("sit")
		self.set_modulate(Color(1, .1, .1, 0.5))
		
		set_physics_process(false)
		
		hurt = 20
		$Timer.start()	



func _on_Timer_timeout():
	hurt -= 1
	
	if hurt < 10:
		set_physics_process(true)
		if hurt <= 0:
			$Timer.stop()
			self.set_modulate(bear_color)
			set_collision_layer_bit(0, true)



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "wake_up": GameManager.change_level("res://src/ui/game_screens/game_over.tscn")



func show_menu() -> void:
	#get_tree().paused = true
	GameManager.menu_is_active = true
	if $Screen/MainMenu/Options.visible: $Screen/MainMenu/Options.hide()
	if $Screen/MainMenu/Help.visible: $Screen/MainMenu/Help.hide()
	if !$Screen/MainMenu/Main.visible: $Screen/MainMenu/Main.show()




func hide_menu() -> void:
	#get_tree().paused = false
	GameManager.menu_is_active = false
	if $Screen/MainMenu/Options.visible: $Screen/MainMenu/Options.hide()
	if $Screen/MainMenu/Help.visible: $Screen/MainMenu/Help.hide()
	if $Screen/MainMenu/Main.visible: $Screen/MainMenu/Main.hide()



func show_help() -> void:
	#get_tree().paused = true
	if $Screen/MainMenu/Options.visible: $Screen/MainMenu/Options.hide()
	if !$Screen/MainMenu/Help.visible: $Screen/MainMenu/Help.show()
	if $Screen/MainMenu/Main.visible: $Screen/MainMenu/Main.hide()

