tool
extends Area2D

export var next_scene: PackedScene

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_Portal2D_body_entered(body):
	teleport()


func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""


func teleport():
	# play fade in animation.
	# wait until animation is done then change scene to next scene
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
