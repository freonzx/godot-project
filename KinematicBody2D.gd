extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 30
const MAX_SPEED = 200
const JUMP_F = -600
const ACCELERATION = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# gravidade
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		# motion.x = SPEED
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		# motion.x = -SPEED
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		motion.x = 0
		$Sprite.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_F
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		
	motion = move_and_slide(motion, UP)
