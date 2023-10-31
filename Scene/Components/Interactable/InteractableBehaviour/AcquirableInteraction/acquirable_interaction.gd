extends Node

signal acquired

func interact(interactor: String, _interacted: String):
	if interactor == "Player":
		acquired.emit()
