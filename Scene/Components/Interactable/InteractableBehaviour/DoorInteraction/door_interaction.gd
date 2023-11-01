extends Node

func interact(_interactor: String, _interacted: String):
    if GlobalStuff.treasure_acquired:
        GlobalStuff.toggle_game_over(true)