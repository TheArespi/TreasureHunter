extends Node

@export var entity_name: String = ""

static var entity_count: int = 0
static var entities = {}

func _ready():
	if entity_name == "":
		entity_name = "entity_" + str(entity_count)
		
	entity_count += 1
	
	entities[entity_name] = get_owner()
