extends Area2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	# Ensure the timer is set to one-shot mode and has the desired delay
	timer.one_shot = true  # The timer will only run once
	timer.wait_time = 1  # Set the delay in seconds (e.g., 3 seconds)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:  # Check if the colliding body is the player
		body.die()  # Call the player's death function
		timer.start()  # Start the timer for the scene reload
		print('you die')
	

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
