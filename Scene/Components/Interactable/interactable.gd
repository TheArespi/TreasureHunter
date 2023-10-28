extends Node

func _ready():
	GlobalStuff.interaction.connect(interaction_happened)

func interaction_happened(interactor: String, interacted: String):
	if get_owner().get_node("EntityInformation").entity_name != interacted:
		return
		
	print(interactor, " interacted with ", interacted)
	
	for interaction_behaviour in get_children():
		interaction_behaviour.interact(interactor, interacted)
