extends KinematicBody2D


# Declare member variables here.
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


func _physics_process(delta):
	# takes the right or left input and set as the input for x axis
	# takes the down or up input and set as the input for y axis
	# then applies as the velocity of move and collide
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector
	else:
		velocity = Vector2.ZERO
		
	move_and_collide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
