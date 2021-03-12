extends KinematicBody


# Game States
var time : int = 100

# Physics
export var moveSpeed : float = 8.0
export var acceleration : float = 5.0
export var jumpForce : float = 10.0
export var gravity : float = 25.0

# Camera Angles
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
export var lookSensitivity : float = 10.0

# vectors
var velocity : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()

# components
onready var camera : Camera = get_node("Camera")

### Functions ###

func _ready():
	
	# Hide and lock mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	# Reset x and z velocity
	velocity.x = 0
	velocity.z = 0
	
	var input = Vector2()

	# Movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	input = input.normalized()
	
	# Get forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = ( forward * input.y + right * input.x )
	
	# Set velocity
	velocity.x = relativeDir.x * moveSpeed
	velocity.z = relativeDir.z * moveSpeed
	
	# Apply gravity
	velocity.y -= gravity * delta
	
	# Player Jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jumpForce
		
	# Player movement
	velocity = move_and_slide(velocity, Vector3.UP)

func _process(delta):
	
	# X-axis Camera Rotation
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	
	# Clamp x-Axis Rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# Y-axis Camera Rotation
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	
	# Reset mouse delta vector
	mouseDelta = Vector2()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
func _input(event):
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
