extends KinematicBody2D


# Member variable
var speed = 600
var velocity = Vector2.ZERO


# Called when the node is "ready"
func _ready():
	randomize()
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.8, 0.8][randi() % 2]


# Called during the physics processing step of the main loop
func _physics_process(delta):
	move_and_slide(velocity * speed)
