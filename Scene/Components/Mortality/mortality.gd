extends Node

@export var health: Node
@export var entity_info: Node

func _ready():
	health.health_reached_zero.connect(_on_health_health_reached_zero)
	
func _on_health_health_reached_zero(entity_name: String):
	if entity_info.entity_name == entity_name:
		GlobalStuff.death.emit(entity_info.entity_name)
		GlobalStuff.delete_entity(entity_info.entity_name)
		get_owner().queue_free()
