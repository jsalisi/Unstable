extends KinematicBody


# Game States
var time : int = 100

# Physics
var moveSpeed : float = 5.0
var jumpForce : float = 5.0
var gravity : float = 12.0

# Camera Angles
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 10.0

# vectors
var velocity : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()

# components
onready var camera : Camera = get_node("Camera")
