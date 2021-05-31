extends CanvasLayer

# signal for starting the game
signal start_game

# function for updating score
func update_score(score):
	# set the score to label
	$ScoreLabel.text = str(score)
	
# function to show message
func show_message(text):
	# set the text to the label text
	$MessageLabel.text = text
	# show the message label
	$MessageLabel.show()
	# start the message timer
	$MessageTimer.start()
	
# function to show game over
func show_game_over():
	# show the Game Over in message label
	show_message("Game Over")
	# wait for the timeout signal from messagetimer
	yield($MessageTimer, "timeout")
	# set the message text of the message label
	$MessageLabel.text = "Dodge the creeps"
	# show the message label
	$MessageLabel.show()
	# wait for 1 second
	yield(get_tree().create_timer(1.0), "timeout")
	# show button
	$Button.show()

# when button is pressed
func _on_Button_pressed():
	# hide the button
	$Button.hide()
	# emit the signal to start game
	emit_signal("start_game")

# triggered when timeout
func _on_MessageTimer_timeout():
	# hide the message label
	$MessageLabel.hide()
