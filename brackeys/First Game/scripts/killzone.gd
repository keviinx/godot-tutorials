extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.5 # game goes half speed when dying
	body.get_node("CollisionShape2D").queue_free()
	timer.start() # start the timer to restart the game


func _on_timer_timeout():
	Engine.time_scale = 1 # reset time scale before reloa d
	get_tree().reload_current_scene() # reloads the game scene after the timer runs out
