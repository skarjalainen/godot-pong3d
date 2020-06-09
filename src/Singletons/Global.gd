extends Node

signal score_changed

const SCORE_TO_WIN = 5

var isStartCounter = false
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

func newScore(playerNumber):
	playerData[playerNumber].score += 1
	emit_signal("score_changed")
