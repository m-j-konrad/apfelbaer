extends KinematicBody2D

class_name LittleBlob



var velocity = Vector2()
var gravity : float = 20
export var direction = -1  #left is -1, right it +1
export var color = Color(0, 1, 0)
var speed : float = 75
var squished : bool = false
export var detects_cliffs : bool = true



func _ready():
	set_physics_process(false) # physics will happen when player is near enough
	
	if direction >0 : 
		$AnimatedSprite.flip_h = true
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x *direction
		$FloorChecker.enabled = detects_cliffs
		
	set_modulate(color)
	$sound_move.play()



func _physics_process(_delta):
	if is_on_wall() or (detects_cliffs and self.is_on_floor() and !$FloorChecker.is_colliding()):
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x *direction
	
	if !squished:
		velocity.y += gravity
		velocity.x = speed*direction
		velocity = self.move_and_slide(velocity,Vector2.UP)



func _on_TopChecker_body_entered(body):
	if !squished and GameManager.blobs_hurt:
		$AnimatedSprite.play("Squash")		# draw dead body
		$sound_squash.play()				# play muddy sound
		$sound_move.stop()					# stop crawling sound
		self.speed = 0
		squished = true
		if body.name == "Bear":
			body.bounce()



func _on_SidesChecker_body_entered(body): 
	if !squished and body.name == "Bear" and GameManager.blobs_hurt: 
		body.ouch(self.position.x)



func _on_sound_squash_finished():
	# disable collisions when actor is dead
	$CollisionShape2D.disabled = true
	$TopChecker/CollisionShape2D.disabled = true
	$SidesChecker/CollisionShape2D.disabled = true
	$SidesChecker/CollisionShape2D2.disabled = true

