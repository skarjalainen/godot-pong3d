extends Popup


func open():
	Global.isPauseMenu = true
	visible = true
	get_tree().paused = true


func close():
	Global.isPauseMenu = false
	visible = false
	if not Global.isStartCounter:
		get_tree().paused = false


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Global.isPauseMenu:
			close()
		else:
			open()


func _on_ContinueButton_pressed():
	close()


func _on_RestartButton_pressed():
	close()
	Scene.goto_scene("res://src/Levels/Level1.tscn")


func _on_QuitButton_pressed():
	close()
	Scene.goto_scene("res://src/UI/MainMenu.tscn")
