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
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.normal)
