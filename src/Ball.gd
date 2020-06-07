extends RigidBody


func _integrate_forces(state):
	state.linear_velocity.x *= 1.001
	state.linear_velocity.z *= 1.001
