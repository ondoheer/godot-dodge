extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()



func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
	
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()




func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)



func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	# choose random location along the path
	$MobPath/MobSpawnLocation.set_offset(randi())
	# create mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# set the mob's direction perpendicular to the path's direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob position at random location
	mob.position = $MobPath/MobSpawnLocation.position
	# Add random to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	# set the velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed),0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	
	
	
	
	
	
	
	
	
	
	
	
	

func start_game():
	pass # Replace with function body.
