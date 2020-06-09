extends MarginContainer

onready var Player1Score = get_node("ScoreContainer/Player1/DataContainer/Score")
onready var Player2Score = get_node("ScoreContainer/Player2/DataContainer/Score")

func _ready():
	Global.connect("score_changed", self, "_on_Global_score_changed")


func _on_Global_score_changed():
	Player1Score.text = var2str(Global.playerData[0].score)
	Player2Score.text = var2str(Global.playerData[1].score)
