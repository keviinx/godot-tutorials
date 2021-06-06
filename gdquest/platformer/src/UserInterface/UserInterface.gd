extends Control

const DIED_MESSAGE := "You died"

var paused := false setget set_paused

onready var scene_tree := get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")


func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	PlayerData.connect("reset", self, "on_Player_reset")
	update_interface()


func _on_PlayerData_player_died():
	self.paused = true
	pause_title.text = DIED_MESSAGE


func on_Player_reset():
	self.paused = false


func _unhandled_input(event):
	if event.is_action_pressed("pause") and pause_title.text != DIED_MESSAGE:
		# this is like calling set_paused
		self.paused = not paused
		scene_tree.set_input_as_handled()


func update_interface():
	score.text = "Score %s" % PlayerData.score


func set_paused(value:bool):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
