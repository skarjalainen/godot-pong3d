extends Node

signal score_changed

const SCORE_TO_WIN = 5

var isStartCounter = false
var isMainMenu = true
var isPauseMenu = false
var isGameOver = false

var playerData = [
	{
		"name": "Player 1",
		"score": 0
	},
	{
		"name": "Player 2",
		"score": 0
	}
]

var config = ConfigFile.new()


func _ready():
	loadSettings()


func loadSettings():
	var err = config.load("user://settings.cfg")
	if err == OK:
		playerData[0].name = config.get_value("user", "name", "Player 1")


func saveSettings():
	var err = config.load("user://settings.cfg")
	config.set_value("user", "name", playerData[0].name)
	err = config.save("user://settings.cfg")


func newScore(playerNumber):
	playerData[playerNumber].score += 1
	emit_signal("score_changed")
