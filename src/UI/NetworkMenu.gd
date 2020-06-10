extends Control


const PORT = 3000

onready var Status = get_node("NinePatchRect/VBoxContainer/Status")
onready var IpInput = get_node("NinePatchRect/VBoxContainer/ButtonContainer/IpInput")
onready var HostButton = get_node("NinePatchRect/VBoxContainer/ButtonContainer/HostButton")
onready var JoinButton = get_node("NinePatchRect/VBoxContainer/ButtonContainer/JoinButton")
onready var IpAddressList = get_node("NinePatchRect/VBoxContainer/ButtonContainer/IpAddressList")


func _ready():
	get_tree().connect("connected_to_server", self, "enter_server")
	get_tree().connect("network_peer_connected", self, "user_entered")
	get_tree().connect("network_peer_disconnected", self, "user_exited")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func user_entered(id):
	print(str(id) + " joined the game")


func user_exited(id):
	print(str(id) + " left the game")


func enter_server():
	var id = get_tree().get_network_unique_id()
	var username = Global.playerData[0].name
	rpc("opponent_connected", id, username)


func host_game():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, 1)
	get_tree().network_peer = host
	Status.text = "Game created, Waiting for opponent.."
	var interfaces = Array(IP.get_local_interfaces())
	var regex = RegEx.new()
	regex.compile("(\\d+\\.\\d+\\.\\d+\\.\\d+)")
	var ips = ["IP ADDRESS LIST"]
	for interface in interfaces:
		if interface && interface.addresses:
			for address in interface.addresses:
				var name = interface.friendly
				if not name:
					name = interface.name
				var result = regex.search(address)
				if result:
					ips.push_back(address + " (" + name + ")")
	IpAddressList.text = PoolStringArray(ips).join("\n")


func join_game():
	var ip = IpInput.text
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, PORT)
	get_tree().network_peer = host


sync func opponent_connected(id, username):
	Status.text = username + " joined the game!"
	Global.playerData[1].name = username


func _on_HostButton_pressed():
	host_game()


func _on_JoinButton_pressed():
	join_game()


func _on_BackButton_pressed():
	get_tree().network_peer = null
	Scene.goto_scene("res://src/UI/MainMenu.tscn")
