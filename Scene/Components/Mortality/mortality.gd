extends Node

@export var health: Node
@export var entity_info: Node

func _ready():
	health.health_reached_zero.connect(health_reached_zero)
	
func health_reached_zero():
	GlobalStuff.death.emit(entity_info.entity_name)
	get_owner().queue_free()
