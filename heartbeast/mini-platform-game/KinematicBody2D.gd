extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550

# Declare member variables here. Examples:
var motion = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called during the physics processing step of the main loop.
func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		
	motion = move_and_slide(motion, UP)
