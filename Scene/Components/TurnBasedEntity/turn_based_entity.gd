extends Node

var current_turn: bool = false

func _ready():
	GlobalStuff.start_turn.connect(entity_turn_start)
	GlobalStuff.end_turn.connect(entity_turn_end)
	
func entity_turn_start(entity: String):
	print("turn start")
	if entity == get_owner().get_node("EntityInformation").entity_name: 
		current_turn = true
		print(get_owner().get_node("EntityInformation").entity_name, " is starting")

func entity_turn_end(entity: String):
	if entity == get_owner().get_node("EntityInformation").entity_name: 
		current_turn = false
