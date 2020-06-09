extends RigidBody

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	resetBall()

func resetBall():
	var side = rng.randi_range(0, 1)
	var velocityX = 4.0
	if rng.randi_range(0, 1) == 0:
		velocityX = -4.0
	var velocityZ
	var translationZ
	if side == 0:
		velocityZ = rng.randf_range(5.0, 10.0)
		translationZ = -10
	else:
		velocityZ = rng.randf_range(-10.0, -5.0)
		translationZ = 10
	set_translation(Vector3(0, 1, translationZ))
	set_linear_velocity(Vector3(velocityX, 0, velocityZ))
	set_angular_velocity(Vector3.ZERO)


func _integrate_forces(state):
	# Make ball accelerate on increasing rate
	state.linear_velocity.x *= 1.001
	state.linear_velocity.z *= 1.001
	# Prevent ball from bouncing up, let it fall down from edge
	if state.linear_velocity.y > 0:
		state.linear_velocity.y = 0


func _process(delta):
	if global_transform.origin.y < -10:
		print(global_transform.origin.z)
		if global_transform.origin.z < 0:
			# New score for player 1
			Global.newScore(0)
		else:
			# New score for player 2
			Global.newScore(1)
		resetBall()
