extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ladder:bool = false


func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation ="Walk"
	else:
		sprite_2d.animation = "Idle"
	# Add the gravity.
	
	if not is_on_floor() and !on_ladder:
		velocity.y += gravity * delta
	# check for ladder climb: 
		if on_ladder:
				if Input.is_action_pressed("down"):
					velocity.y = SPEED*delta*200
				elif Input.is_action_just_pressed("up"):
					velocity.y = -SPEED*delta*200
				else:
					velocity.y = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("Dash"):
			velocity.x = 1000

	move_and_slide()
	print(on_ladder)
	#Change Direction
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	# Ladder Detection
	
func _on_ladder_body_entered(body: Node2D) -> void:
	if "CharacterBody2D" in body.name:
		on_ladder = true


func _on_ladder_body_exited(body: Node2D) -> void:
	if "CharacterBody2D" in body.name:
		on_ladder = false
