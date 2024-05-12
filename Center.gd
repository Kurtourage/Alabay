extends Area2D

var maxSpeed = 2000.0  # Adjust this value to change the maximum speed of the tug of war movement
var acceleration = 100.0  # Adjust this value to change the acceleration rate
var constantRightForce = 10.0  # Adjust this value to change the constant force pushing the object to the right

var velocity = Vector2.ZERO

var winAreaPosition = Vector2(-74.0, 0.0)  # Adjust this position based on where you want the win area to be
var Prompt: Label

var LoseAreaPosition = Vector2(78.0, 0.0) # adjust position based on lose area at the right, add a 1-3 allowance

func _ready():
	# Find and store a reference to the UI prompt node
	Prompt = $UIPrompt
	if Prompt != null:
		Prompt.hide()  # Hide the prompt initially   

func _process(delta):
	if position.x <= winAreaPosition.x:
		# Stop movement
		velocity = Vector2.ZERO
		constantRightForce = 0.0
		# Show the "You Win!" UI prompt
		Prompt.text = "You Win!"
		Prompt.show()
		
		
	if position.x >= LoseAreaPosition.x:
		# Stop movement
		velocity = Vector2.ZERO
		constantRightForce = 0.0
		# Show the "You Win!" UI prompt
		Prompt.text = "You Lose!"
		Prompt.show()
		
	# Apply a constant force to the right
	velocity.x += constantRightForce * delta

	if Input.is_action_pressed("space"):
		# Increase velocity to the left when space is pressed
		# change integer to change how much increase in acceleration
		velocity.x -= acceleration * 4 * delta
	else:
		# Slow down velocity when space is not pressed
		velocity.x = lerp(velocity.x, constantRightForce, 0.1)  # Smoothly decrease velocity to the constant right force

	# Limit velocity to the maximum speed
	velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)

	# Move the tug of war object
	position += velocity * delta

	# Check if the tug of war object is in the tug area
	
	# Print velocity for testing (remove this line in the final version)
	print("Velocity: ", velocity)
