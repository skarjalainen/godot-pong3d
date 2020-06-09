extends MarginContainer

const START_VALUE = 3
var value = START_VALUE
onready var label = get_node("Value")
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("score_changed", self, "_on_Global_score_changed")
	timer.connect("timeout", self, "_on_Timer_timeout")
	startCounter()

func updateCounterValue():
	label.text = var2str(value)

func startCounter():
	Global.isStartCounter = true
	value = START_VALUE
	updateCounterValue()
	visible = true
	timer.start()
	get_tree().paused = true
	
func stopCounter():
	Global.isStartCounter = false
	timer.stop()
	visible = false
	get_tree().paused = false

func _on_Timer_timeout():
	if Global.isPauseMenu:
		return
	value -= 1
	updateCounterValue()
	if value == 0:
		stopCounter()

func _on_Global_score_changed():
	startCounter()
