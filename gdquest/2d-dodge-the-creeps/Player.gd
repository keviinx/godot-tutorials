extends Area2D

# signal for when player is hit
signal hit

# Declare member variables here.
# variable for player speed
export var speed = 400.0
# variable for screen size
var screen_size = Vector2.ZERO

# Called when the node is "ready", i.e. when both the node and its children have entered the scene tree.
func _ready():
	# get the screen size from the engine
	screen_size = get_viewport_rect().size
	# hide the player
	# hide the player
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# default direction is Vector2.ZERo
	var direction = Vector2.ZERO
	# if D key press detected
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	# if A key press detected
	if Input.is_action_pressed("move_left"):
		direction.x -= 1	
	# if S key press detected
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	# if W key press detected
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	# if two key press is detected, also if one key is pressed
	if direction.length() > 0:
		# normalize the speed
		direction = direction.normalized()
		# play animation when moving
		$AnimatedSprite.play()
	else:
		# stop animation when idle
		$AnimatedSprite.stop()
		
	# calculation to move the player
	position += direction * speed * delta
	# clamp the position x of the player between 0 and the maximum screen size x axis
	position.x = clamp(position.x, 0, screen_size.x)
	# clamp the position y of the player between 0 and the maximym screen size y axis
	position.y = clamp(position.y, 0, screen_size.y)
	
	# if player move along x axis
	if direction.x != 0:
		# set animation set to right
		$AnimatedSprite.animation = "right"
		# flip_v is not done
		$AnimatedSprite.flip_v = false
		# flip_h is true if moving left
		$AnimatedSprite.flip_h = direction.x < 0
	# if player move along y axis
	elif direction.y != 0:
		# set animation set to up
		$AnimatedSprite.animation = "up"
		# flip_v is true if moving down
		$AnimatedSprite.flip_v = direction.y > 0
		# flip_h is not done
		$AnimatedSprite.flip_h = false

# function to be called when starting the game
func start(new_position):
	# set the new position as position
	position = new_position
	# show the player
	show()
	# enable the collisionshape2d, no need to use set_deferred because no physics calculation is happening
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	# hide the player on collision
	hide()
	# disable the collisionshape2d
	# set_deferred - Assigns a new value to the given property, after the current frame's physics step.
	$CollisionShape2D.set_deferred("disabled", true)
	# emit the hit signal
	emit_signal("hit")
