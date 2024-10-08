extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 700

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

var is_dead = false  # Player death state
	
func _physics_process(delta):
	if is_dead:  # Prevent any movement if the player is dead
		return
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
				
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		
	var horizontal_direction = Input.get_axis("move_left","move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction != 0:
		sprite.flip_h = (horizontal_direction == -1)
	
	move_and_slide()
	
	update_animations(horizontal_direction)

func update_animations(horizontal_direction):
	if is_dead:  # Prevent animation updates if the player is dead
		return
		
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")

func die():
	is_dead = true  # Mark the player as dead
	ap.play("die")  # Play death animation
	velocity = Vector2.ZERO  # Stop all movement
