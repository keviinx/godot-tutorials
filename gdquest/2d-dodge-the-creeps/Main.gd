extends Node

# Declare member variables here.
# to import the mob scene
export (PackedScene) var mob_scene
# variable to keep track of the score
var score = 0

# Called when the node is "ready", i.e. when both the node and its children have entered the scene tree.
func _ready():
	# Randomizes the seed (or the internal state) of the random number generator.
	randomize()

# function to start a new game
func new_game():
	# reset the score
	score = 0
	# update the score on the HUD
	$HUD.update_score(score)
	
	# get the group mobs and apply queuefree
	get_tree().call_group("mobs", "queue_free")
	# set the player position when the game starts
	$Player.start($StartPosition.position)
	
	# start the starttimer
	$StartTimer.start()
	# play the music
	$Music.play()
	
	# show the message
	$HUD.show_message("Get ready...")
	
	# yield - Stops the function execution and returns the current suspended state to the calling function.
	yield($StartTimer, "timeout")
	
	# start the scoretimer
	$ScoreTimer.start()
	# start the mobtimer
	$MobTimer.start()

# function for game over
func game_over():
	# stop the score timer
	$ScoreTimer.stop()
	# stop the mob timer
	$MobTimer.stop()
	# show game over message on the HUD
	$HUD.show_game_over()
	# stop the music
	$Music.stop()
	# play the game over music
	$DeathSound.play()

func _on_MobTimer_timeout():
	# load the mob spawn location to a variable
	var mob_spawn_location = $MobPath/MobSpawnLocation
	# set the unit offset from the output of randf
	# randf - Returns a random floating point value on the interval [0, 1].
	mob_spawn_location.unit_offset = randf()
	
	# instance a mob scene to a variable
	var mob = mob_scene.instance()
	# add a child node with mob to the main node
	add_child(mob)
	
	# set the mob position to the position generated by the mob spawn location
	mob.position = mob_spawn_location.position
	
	# get the direction from the mob spawn location + (pi / 2 = 90 degrees) and set the a variable 
	var direction = mob_spawn_location.rotation + PI / 2
	# add the direction with a random angle betwee -45 degrees to 45 degrees
	direction += rand_range(-PI / 4, PI / 4)
	# set the mob rotation to the direction generated
	mob.rotation = direction
	
	#get a random range between min speed and max speed to set for x axis of the velocity variable
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	# set the linear velocity to the rotated direction of the velocity
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	# increment the score by one
	score += 1
	# update the score on the HUD
	$HUD.update_score(score)