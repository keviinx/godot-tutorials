extends Actor

export var score := 100

onready var stomp_area: Area2D = $StompDetector

func _ready():
	# disable physics process when not in view
	set_physics_process(false)
	_velocity.x = -speed.x


func _on_StompDetector_body_entered(body):
	# if the position y of body is lower than stompdetector, do nothing
	# else disable collision and kill enemy
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
		
	get_node("CollisionShape2D").disabled = true
	die()


func _physics_process(delta):
	_velocity.x *= -1 if is_on_wall() else 1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die():
	queue_free()
	PlayerData.score += score
