extends RigidBody

# 
func _integrate_forces(state):
	# Make ball accelerate on increasing rate
	state.linear_velocity.x *= 1.001
	state.linear_velocity.z *= 1.001
	# Prevent ball from bouncing up, let it fall down from edge
	if state.linear_velocity.y > 0:
		state.linear_velocity.y = 0
