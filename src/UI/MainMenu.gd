extends Control


const PORT = 3000

onready var NameInput = get_node("NinePatchRect/ButtonContainer/NameInput")


func _ready():
	NameInput.text = Global.playerData[0].name


func savePlayerName():
	Global.playerData[0].name = NameInput.text
	Global.saveSettings()

func _on_SinglePlayerButton_pressed():
	savePlayerName()
	Scene.goto_scene("res://src/Levels/Level1.tscn")


func _on_MultiPlayerButton_pressed():
	savePlayerName()
	Scene.goto_scene("res://src/UI/NetworkMenu.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
