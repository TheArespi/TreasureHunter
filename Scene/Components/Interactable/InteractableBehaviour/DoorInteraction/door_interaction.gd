extends Node

func interact(_interactor: String, _interacted: String):
    if GlobalStuff.treasure_acquired:
        print("Game Over success!")