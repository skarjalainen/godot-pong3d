class_name Player
extends KinematicBody

var velocity = Vector3()
export var ACCELERATION = 0.3
export var player_id = "p1"


func _physics_process(delta):
	if Input.is_action_pressed(player_id + "_up"):
		velocity.x -= ACCELERATION
	if Input.is_action_pressed(player_id + "_down"):
		velocity.x += ACCELERATION
	velocity = move_and_slide(velocity)
	
