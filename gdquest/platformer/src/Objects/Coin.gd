extends Area2D

export var score := 100

onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")


func _on_Coin_body_entered(body):
	# play fade out animation when player touches the coin
	PlayerData.score += score
	animation_player.play("fade_out")
