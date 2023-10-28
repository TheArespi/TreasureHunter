extends Node

signal acquired

func interact(interactor: String, interacted: String):
	if interactor == "Player":
		acquired.emit()
