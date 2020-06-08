extends MarginContainer

const START_VALUE = 3
var value = START_VALUE
onready var label = get_node("Value")
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	startCounter()

func updateCounterValue():
	label.text = var2str(value)

func startCounter():
	value = START_VALUE
	updateCounterValue()
	label.visible = true
	timer.start()
	get_tree().paused = true
	
func stopCounter():
	timer.stop()
	label.visible = false
	get_tree().paused = false

func _on_Timer_timeout():
	value -= 1
	updateCounterValue()
	if value == 0:
		stopCounter()
