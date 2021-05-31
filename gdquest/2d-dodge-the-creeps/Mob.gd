extends RigidBody2D

# Declare member variables here.
# mob minimum speed
export var min_speed = 150.0
# mob maximum speed
export var max_speed = 250.0

# Called when the node is "ready", i.e. when both the node and its children have entered the scene tree.
func _ready():
	# play animated sprite
	$AnimatedSprite.playing = true
	# get the mob types from frames
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# set the animation randomly
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

# this function is called when the VisibilityNotifier2D exits the screen
func _on_VisibilityNotifier2D_screen_exited():
	# free monster from the memory
	queue_free()
