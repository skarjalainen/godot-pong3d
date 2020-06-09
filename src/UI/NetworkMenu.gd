extends Control


const PORT = 3000

onready var Status = get_node("ColorRect/Status")
onready var IpInput = get_node("ColorRect/MarginContainer/ButtonContainer/IpInput")


func _ready():
	get_tree().connect("connected_to_server", self, "enter_room")
	get_tree().connect("network_peer_connected", self, "user_entered")
	get_tree().connect("network_peer_disconnected", self, "user_exited")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func user_entered(id):
	Status.text = str(id) + " joined the game"


func user_exited(id):
	Status.text = str(id) + " left the game"


func host_game():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, 1)
	get_tree().network_peer = host
	Status.text = "Game created, waiting for opponent"


func join_game():
	var ip = IpInput.text
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, PORT)
	get_tree().network_peer = host


func send_message():
	var msg = "message"
	var id = get_tree().get_network_unique_id()
	rpc("receive_message", id, msg)


sync func receive_message(id, msg):
	Status.text = str(id) + ": " + msg


func _on_HostButton_pressed():
	host_game()


func _on_JoinButton_pressed():
	join_game()


func _on_BackButton_pressed():
	Scene.goto_scene("res://src/UI/MainMenu.tscn")
