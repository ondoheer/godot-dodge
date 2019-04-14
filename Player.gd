extends Area2D

export (PackedScene) var Mob

signal hit
export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y , 0, screen_size.y)
	
	if velocity.x != 0:
		# calls right animation sprites
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		# if x is negative value flips it so it "points in the other direction"
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
	

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	
	$CollisionShape2D.call_deferred("set_disabled", true)

func reset_Player_animation():
	
	$AnimatedSprite.flip_v = false
	$AnimatedSprite.animation = "up"
	$AnimatedSprite.frame = 0
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	reset_Player_animation()
	
