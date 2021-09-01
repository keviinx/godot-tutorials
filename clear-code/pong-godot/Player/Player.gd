extends KinematicBody2D

# Member variable
var speed = 400

# Called during the physics processing step of the main loop
func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	move_and_slide(velocity * speed)
