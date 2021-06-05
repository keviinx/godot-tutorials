extends Area2D

onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")


func _on_Coin_body_entered(body):
	# play fade out animation when player touches the coin
	animation_player.play("fade_out")
