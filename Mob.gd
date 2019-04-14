extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

var mob_types = ["fly", "swim", "walk"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	self.connect("body_entered", self, "_on_Player_hit")
	

func _on_Visibility_screen_exited():
	queue_free()

func _on_Player_hit():
	queue_free()
	